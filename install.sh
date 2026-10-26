#!/bin/bash
#
# Install GNU Stow if needed and link this repository's dotfiles into $HOME.
# Safe to re-run: Stow leaves correct links alone and refuses to overwrite
# conflicting files.

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./install.sh [--dry-run]

Install and stow bash, bin, git, homebrew, readline, and zsh
dotfiles. On macOS, also let sudo take Touch ID.
--dry-run reports the changes without applying them.
EOF
}

dry_run=false
case ${1:-} in
  "") ;;
  -h|--help) usage; exit ;;
  --dry-run) dry_run=true ;;
  *) echo "install.sh: unknown argument: $1" >&2; usage >&2; exit 2 ;;
esac
[[ $# -le 1 ]] || { echo "install.sh: expected at most one argument" >&2; exit 2; }

repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Avoid links into a disposable Git worktree unless explicitly requested.
if git -C "$repo" rev-parse --git-dir >/dev/null 2>&1; then
  own_git_dir=$(git -C "$repo" rev-parse --absolute-git-dir)
  shared_git_dir=$(cd "$repo" && cd "$(git rev-parse --git-common-dir)" && pwd)
  if [[ $own_git_dir != "$shared_git_dir" ]]; then
    canonical=$(dirname "$shared_git_dir")
    echo "install.sh: refusing to install from a git worktree." >&2
    echo "  here:      $repo" >&2
    echo "  canonical: $canonical" >&2
    echo "Symlinks would break when this worktree is removed." >&2
    echo "Run $canonical/install.sh instead." >&2
    [[ ${ALLOW_WORKTREE_INSTALL:-} == 1 ]] || exit 1
    echo "install.sh: ALLOW_WORKTREE_INSTALL=1 set - continuing anyway." >&2
  fi
fi

if ! command -v stow >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    install_command=(brew install stow)
  elif command -v apt-get >/dev/null 2>&1; then
    install_command=(sudo apt-get install -y stow)
  else
    echo "install.sh: GNU Stow is required; install it and rerun this script." >&2
    exit 1
  fi

  if [[ $dry_run == true ]]; then
    printf 'install would run:'
    printf ' %q' "${install_command[@]}"
    printf '\n'
    exit
  fi

  "${install_command[@]}"
fi

packages=(bash bin git homebrew readline zsh)
# Finder drops .DS_Store into package folders, and $HOME has its own.
stow_args=(--dir="$repo" --target="$HOME" --stow --verbose=1 --ignore='\.DS_Store')
[[ $dry_run == true ]] && stow_args+=(--simulate)

stow "${stow_args[@]}" "${packages[@]}"

# Let sudo take Touch ID. macOS keeps sudo_local across updates, unlike
# /etc/pam.d/sudo, and ships its template with the line commented out. An
# existing sudo_local is left alone.
pam_template=/etc/pam.d/sudo_local.template
pam_local=/etc/pam.d/sudo_local
if [[ -f $pam_template && ! -e $pam_local ]]; then
  if [[ $dry_run == true ]]; then
    echo "install would enable Touch ID for sudo in $pam_local"
  else
    echo "install.sh: sudo is needed to enable Touch ID by creating $pam_local."
    sed 's/^#auth/auth/' "$pam_template" | sudo tee "$pam_local" >/dev/null
  fi
fi

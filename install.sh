#!/bin/bash
#
# Install GNU Stow if needed and link this repository's dotfiles into $HOME.
# Safe to re-run: Stow leaves correct links alone and refuses to overwrite
# conflicting files.

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./install.sh [--dry-run]

Install and stow bash, bin, git, powershell, readline, and zsh dotfiles.
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

packages=(bash bin git powershell readline zsh)
stow_args=(--dir="$repo" --target="$HOME" --stow --verbose=1)
[[ $dry_run == true ]] && stow_args+=(--simulate)

stow "${stow_args[@]}" "${packages[@]}"

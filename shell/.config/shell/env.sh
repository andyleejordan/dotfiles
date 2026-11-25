. "$HOME/.config/shell/path-edit.sh"

export BASH_ENV="$HOME/.config/bash/env.bash"

# Preserve inherited system ordering; only promote Homebrew ahead of it.
path_front /opt/homebrew/bin /opt/homebrew/sbin
path_back \
  "$HOME/bin" \
  "$HOME/.local/bin" \
  "$HOME/.dotnet" \
  "$HOME/.dotnet/tools" \
  /usr/local/share/dotnet

if [[ -f $HOME/.cargo/env ]]; then
  . "$HOME/.cargo/env"
fi

if [[ -r $HOME/.local/share/shell/env.sh ]]; then
  . "$HOME/.local/share/shell/env.sh"
fi

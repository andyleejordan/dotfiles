# SSH agent socket (when not already set by the system)
if [[ -z $SSH_AUTH_SOCK ]]; then
  ssh_sock_file=(/tmp/ssh-*/agent.*(N))
  [[ -S $ssh_sock_file[1] ]] && export SSH_AUTH_SOCK=$ssh_sock_file[1]
  unset ssh_sock_file
fi

# path
typeset -U path

# prepend (front-most last)
for dir in /opt/homebrew/bin; do
  [[ -d $dir ]] && path=($dir $path)
done

# append
for dir in \
  ~/bin \
  ~/.local/bin \
  ~/.dotnet/tools \
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
do
  [[ -d $dir ]] && path+=($dir)
done

if command -v brew > /dev/null; then
  eval "$(brew shellenv)"
fi

# Rust
if [[ -f ~/.cargo/env ]]; then
  . ~/.cargo/env
fi

# Local
if [[ -r ~/.local/share/zsh/env.zsh ]]; then
  source ~/.local/share/zsh/env.zsh
fi

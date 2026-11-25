typeset -U path
. "$HOME/.config/shell/env.sh"

if [[ -z $SSH_AUTH_SOCK ]]; then
  ssh_sock_file=(/tmp/ssh-*/agent.*(N))
  [[ -S $ssh_sock_file[1] ]] && export SSH_AUTH_SOCK=$ssh_sock_file[1]
  unset ssh_sock_file
fi

# Local
if [[ -r ~/.local/share/zsh/env.zsh ]]; then
  source ~/.local/share/zsh/env.zsh
fi

. "$HOME/.config/shell/env.sh"

if [[ -z ${SSH_AUTH_SOCK:-} ]]; then
  for ssh_sock_file in /tmp/ssh-*/agent.*; do
    if [[ -S $ssh_sock_file ]]; then
      export SSH_AUTH_SOCK=$ssh_sock_file
      break
    fi
  done
  unset ssh_sock_file
fi

# Local
if [[ -r ~/.local/share/bash/env.bash ]]; then
  source ~/.local/share/bash/env.bash
fi

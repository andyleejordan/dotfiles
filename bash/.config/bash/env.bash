# Find SSH agent socket file
ssh_sock_file=$(compgen -G "/tmp/ssh-*/agent.*" | head -n 1)
if [[ -z $SSH_AUTH_SOCK && -S $ssh_sock_file ]]; then
    export SSH_AUTH_SOCK=$ssh_sock_file
fi

# Path setup
source ~/.config/bash/path-edit.bash
path_front /sbin /usr/sbin /usr/local/sbin /usr/local/bin /usr/bin /bin
path_back ~/bin ~/.local/bin ~/.poetry/bin ~/.cargo/bin ~/.dotnet/tools /usr/local/share/dotnet /usr/local/microsoft/powershell/7

# macOS
path_back /opt/homebrew/bin/ "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"

# Local
if [[ -r ~/.local/share/bash/env.bash ]]; then
    source ~/.local/share/bash/env.bash
fi

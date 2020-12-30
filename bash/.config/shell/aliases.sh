# Emacs as editor in server/client mode
# Enable systemd unit with: systemctl --user enable --now emacs
# See logs with: journalctl --user-unit emacs
export ALTERNATE_EDITOR=""
if [[ -n $DISPLAY ]]; then
    alias e='emacsclient --create-frame --no-wait'
else
    alias e='emacsclient'
fi
export VISUAL=e EDITOR=e

# p: a common package manager interface
source ~/.config/shell/packages.sh

# miscellaneous
alias sudo='sudo ' # enable alias expansion for sudo
alias g='git'
complete -o default -o nospace -F _git g
alias make='make --debug=b'
alias ping='ping -c 8'
alias root='sudo su'
alias cppc='cppcheck --std=c++11 --enable=all --suppress=missingIncludeSystem .'
alias octave='octave --quiet'
if command -v thefuck >/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

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
source ~/.config/bash/packages.bash

# colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

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

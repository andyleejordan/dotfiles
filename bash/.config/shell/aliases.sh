# Emacs as editor
alias e='emacsclient --alternate-editor="" --no-wait'
# and open a new frame
alias ec='e --create-frame'
# in the terminal
alias et='e --tty'

# create a frame when programs invoke the editor
export VISUAL=ec EDITOR=ec

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

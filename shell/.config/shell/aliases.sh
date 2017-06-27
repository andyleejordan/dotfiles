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

# system dependent
if [[ $OSTYPE == darwin* ]]
then
    # power
    alias shutdown='sudo shutdown -hP now'
    alias reboot='sudo reboot now'
    alias sleep='shutdown -s now'

    # misc
    alias unlock_files='chflags -R nouchg *'
elif [[ $OSTYPE == linux-gnu ]]
then
    # power
    alias shutdown='sudo shutdown -P now'
    alias reboot='sudo shutdown -r now'
    alias halt='sudo halt -P'
fi

# miscellaneous
alias sudo='sudo ' # enable alias expansion for sudo
alias g='git'
complete -o default -o nospace -F _git g
alias make='make --debug=b'
alias ping='ping -c 8'
alias r='run'
alias root='sudo su'
alias cppc='cppcheck --std=c++11 --enable=all --suppress=missingIncludeSystem .'
alias octave='octave --quiet'
alias rg='rg --smart-case'

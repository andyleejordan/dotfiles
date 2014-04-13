# prezto
prezto_init="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
[[ -s $prezto_init ]] && [[ $TERM != "dumb" ]] && source $prezto_init

# source common configuration
source ~/.shrc

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

# prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# source common configuration
source ~/.shrc

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

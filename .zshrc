# source common configuration
source ~/.shrc

# prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="sorin"
DISABLE_AUTO_UPDATE=true

source ~/.fresh/build/shell.sh
source $ZSH/oh-my-zsh.sh

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

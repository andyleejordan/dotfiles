# Setup environment
ZSH="$HOME/.oh-my-zsh" # Point to location of oh-my-zsh
PATH="/usr/local/bin:/usr/local/share/python:$PATH:."
TERM="xterm-256color" # Fixes color issues
ZSH_THEME=""
MY_ZSH_THEME=$ZSH_THEME
DEFAULT_USER="andrew" # Used for agnoster
EDITOR="vim"

# Command exists function
_command_exists() {
    type "$1" &> /dev/null ;
}

# Show the fortune while we set up other things
if _command_exists fortune && [ "$TERM_PROGRAM" != "DTerm" ]; then
    fortune
    echo
fi

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    brew
    extract
    git
    history
    osx
    python
    url-tools
    vi-mode)

source $ZSH/oh-my-zsh.sh
source "/Users/andrew/Code/agnoster/agnoster.zsh-theme"

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

# Load aliases
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

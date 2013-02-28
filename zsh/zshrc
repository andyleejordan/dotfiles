# Setup environment
ZSH="$HOME/.oh-my-zsh" # Point to location of oh-my-zsh
PATH="/usr/local/bin:/usr/local/share/python:$PATH:."
TERM="xterm-256color" # Fixes color issues
ZSH_THEME=""
MY_ZSH_THEME=$ZSH_THEME
DEFAULT_USER="andrew" # Used for agnoster
EDITOR="vim"
DOTFILES="$HOME/.dotfiles"

# Command exists function
_command_exists() {
    type "$1" &> /dev/null ;
}

# Show the fortune while we set up other things
if _command_exists fortune && [ "$TERM_PROGRAM" != "DTerm" ]; then
    fortune
    echo
fi

# Common plugins
plugins=(
    autojump
    extract
    git
    history
    pip
    python
    url-tools
    vi-mode)

# Common aliases
source $DOTFILES/aliases/aliases.zsh

# GNU plugins/aliases
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(
        aptitude
        debian)
    source $DOTFILES/.gnu.zsh
# Mac OS X plugins/aliases
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(
        brew
        osx)
    source $DOTFILES ~/.osx.zsh
fi

source $ZSH/oh-my-zsh.sh
source "/Users/andrew/Code/agnoster/agnoster.zsh-theme"

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

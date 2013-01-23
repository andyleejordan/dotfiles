# Setup environment
ZSH=$HOME/.oh-my-zsh # Point to location of oh-my-zsh
PATH=$PATH:. # Big security risk, but very convenient, use at own risk
TERM="xterm-256color" # Fixes color issues
ZSH_THEME="agnoster" # Awesome Solarized theme
DEFAULT_USER="andrew" # Used for agnoster
EDITOR="vim"

# Tmux: Make new session if none available, else reattach
if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Command exists function
_command_exists() {
    type "$1" &> /dev/null ;
}

# Show the fortune while we set up other things
if _command_exists fortune && [ "$TERM_PROGRAM" != "DTerm" ]; then
    fortune
    echo
fi

# Fix ls colors with Solarized, file found in .dotfiles
if _command_exists dircolors; then
    eval `dircolors ~/.dir_colors`
fi

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    autojump
    compleat
    debian
    extract
    git
    git-extras
    python
    url-tools
    vi-mode)

source $ZSH/oh-my-zsh.sh

# Zsh configuration
limit coredumpsize 0
setopt menu_complete
setopt no_beep

# Temporary workaround for tab completion LS_COLORS; Issue #1563
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Vi style
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward  

# Load bash aliases
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

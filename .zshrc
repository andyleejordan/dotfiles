# Setup environment
ZSH=$HOME/.oh-my-zsh
PATH=$PATH:. # Big security risk, but very convenient, use at own risk
TERM=xterm-256color # Fixes color issues
HISTSIZE=10000
ZSH_THEME="agnoster"
DEFAULT_USER="andrew"

# Tmux: Make new session if none available, else reattach
if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Zsh configuration
setopt auto_cd
setopt extended_glob
setopt notify
setopt complete_in_word
setopt list_packed
setopt list_types
setopt rec_exact
setopt hist_verify
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt append_history
setopt extendedhistory
setopt inc_append_history

autoload -Uz compinit && compinit

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(autojump command-not-found debian extract git git-extras lol python vi-mode)

source $ZSH/oh-my-zsh.sh

# Command exists function
_command_exists() {
    type "$1" &> /dev/null ;
    }

# Show the fortune while we set up other things
if _command_exists fortune && [ "$TERM_PROGRAM" != "DTerm" ]; then
    fortune
    echo
fi

# Load bash aliases
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

# Fix ls colors with solarized, file found in .dotfiles
if _command_exists dircolors; then
    eval `dircolors --bourne-shell ~/.dir_colors`
fi

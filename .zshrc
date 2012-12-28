# Setup environment
ZSH=$HOME/.oh-my-zsh
PATH=$PATH:. # Big security risk, but very convenient, use at own risk
TERM=xterm-256color # Fixes color issues
ZSH_THEME="robbyrussell"

# Tmux: Make new session if none available, else reattach
if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git extract)

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

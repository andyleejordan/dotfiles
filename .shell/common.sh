# this file is sourced by .bashrc and .zshrc

# path setup
source ~/.shell/path-edit.sh
path_front ~/bin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin

# aliases
source ~/.shell/aliases.sh

# liquidprompt
[[ -e ~/.liquidprompt/ && $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# assume colors work
export TERM=xterm-256color

# set Tmux theme
export TMUX_THEME=dark

# less options
export LESS='-g -i -M -R -S -w -z-4'
# enable ls colors
if ls --color=auto 2> /dev/null; then
    alias ls="ls --color=auto"
else
    export CLICOLOR=1
fi

# source everything else
source ~/.shell/local.sh

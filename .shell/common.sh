# this file is sourced by .bashrc and .zshrc

# path setup
source ~/.shell/path-edit.sh
path_front ~/bin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin

# aliases
source ~/.shell/aliases.sh

## disable flow control
stty -ixon

# liquidprompt
[[ ( -e ~/.liquidprompt/ ) && ( $- = *i* ) ]] && source ~/.liquidprompt/liquidprompt

# assume colors work
export TERM=xterm-256color

# less options
export LESS='-g -i -M -R -S -w -z-4'

# source everything else
[[ -e ~/.shell/local.sh ]] && source ~/.shell/local.sh

# ~/.bashrc: executed by bash(2) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set environment
PATH=$PATH:. # Big security risk, but very convenient, use at own risk
TERM=xterm-256color # Fixes color issues

# Colorized bash prompt
export PS1="\[\e[0;32m\][\h: \W]\$ \[\e[0m\]" # It's so pretty

# tmux: Make new session if none available, else reattach
if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

# Set vi keys for bash instead of emacs
set -o vi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Fix ls colors with solarized, file found in .dotfiles
if _command_exists dircolors; then
    eval `dircolors --bourne-shell ~/.dir_colors`
fi

# Run local config
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

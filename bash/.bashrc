# this file is sourced by non-login interactive shells and ~/.bash_profile

# disable everything for "dumb" terminals such as Emacs' Tramp
if [[ "$TERM" == "dumb" ]]; then
    return
fi

# print quote
if shopt -q login_shell; then
    echo History repeats itself:
    echo the first time as tragedy,
    echo the second time as farce.
fi

# XDG config
if [[ ! -x "$XDG_CONFIG_HOME" ]]; then
    shell_config="$HOME/.config/shell"
else
    shell_config="$XDG_CONFIG_HOME/shell"
fi

if [[ ! -x "$shell_config" ]]; then
    mkdir -p "$shell_config"
fi

# XDG data
if [[ ! -x "$XDG_DATA_HOME" ]]; then
    shell_data="$HOME/.local/share/shell"
else
    shell_data="$XDG_DATA_HOME/shell"
fi

if [[ ! -x "$shell_data" ]]; then
    mkdir -p "$shell_data"
fi

# path setup
source "$shell_config/path-edit.sh"
path_front /sbin /usr/sbin /usr/local/sbin /usr/local/bin /usr/bin /bin
path_back ~/bin ~/.local/bin ~/.poetry/bin ~/.cargo/bin /usr/local/go/bin

# completion setup
source "$shell_config/git-completion.bash"

# cd options
shopt -s cdspell
if ((BASH_VERSINFO >= 4)); then
    shopt -s autocd dirspell
fi

# glob options
shopt -s dotglob extglob nocaseglob
if ((BASH_VERSINFO >= 4)); then
    shopt -s globstar
fi

# job options
shopt -s huponexit
if ((BASH_VERSINFO >= 4)); then
    shopt -s checkjobs
fi

# shell options
shopt -s checkhash checkwinsize

# history
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth
# Unset for unlimited history
HISTSIZE=
HISTFILESIZE=
# Use separate history file to avoid truncation
HISTFILE="$shell_data/bash_history"

# prompt setup
source "$shell_config/git-prompt.sh"
PROMPT_DIRTRIM=2

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM=auto

set_prompt () {
    local last_command=$?
    PS1=''

    # save after every command
    history -a

    # color escape codes
    local color_off='\[\e[0m\]'
    local color_red='\[\e[0;31m\]'
    local color_green='\[\e[0;32m\]'
    local color_yellow='\[\e[0;33m\]'
    local color_blue='\[\e[0;34m\]'
    local color_purple='\[\e[0;35m\]'
    local color_cyan='\[\e[0;36m\]'

    # add purple exit code if non-zero
    if [[ $last_command != 0 ]]; then
        PS1+=$color_purple
        PS1+='$? '
        PS1+=$color_off
    fi

    # hostname
    if [[ -n $SSH_CONNECTION ]]; then
        PS1+=$color_green
    else
        PS1+=$color_blue
    fi

    PS1+="@"
    PS1+=$color_off
    PS1+="\h "

    # shortened working directory
    PS1+=$color_blue
    PS1+='\w '
    PS1+=$color_off

    # add Git status with color hints
    PS1+="$(__git_ps1 '%s ')"

    # red for root, cyan for user
    if [[ $EUID == 0 ]]; then
        PS1+=$color_red
    else
        PS1+=$color_cyan
    fi

    # end of prompt
    PS1+='\n> '
    PS1+=$color_off
}
PROMPT_COMMAND='set_prompt'

# aliases
source "$shell_config/aliases.sh"

# enable ls colors
if ls --color=auto &> /dev/null; then
    alias ls='ls --color=auto'
else
    export CLICOLOR=1
fi

# colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

# disable flow control so C-s and C-q work
if [[ -t 1 ]]; then
    stty -ixon -ixoff
fi

# source local configurations
if [[ -r "$shell_config/local.sh" ]]; then
    source "$shell_config/local.sh"
fi

# OCaml setup
if [[ -r ~/.opam/opam-init/init.sh ]]; then
    source ~/.opam/opam-init/init.sh &> /dev/null
fi

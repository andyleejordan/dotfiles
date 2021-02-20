# Disable for "dumb" terminals such as Emacs' Tramp
if [[ "$TERM" == "dumb" ]]; then
    return
fi

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

# history options
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth
# Unset for unlimited history
HISTSIZE=
HISTFILESIZE=
# Use separate history file to avoid truncation
mkdir -p ~/.local/share/bash
HISTFILE=$HOME/.local/share/bash/bash_history

# prompt setup
source ~/.config/bash/git-prompt.bash
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
    PS1+='\n$ '
    PS1+=$color_off
}
PROMPT_COMMAND='set_prompt'

# aliases
source ~/.config/bash/aliases.bash

# enable ls colors
if ls --color=auto &> /dev/null; then
    alias ls='ls --color=auto'
elif gls --color &> /dev/null; then
    alias ls='gls --color'
else
    export CLICOLOR=1
fi

# Disable flow control so C-s and C-q work
if [[ -t 1 ]]; then
    stty -ixon -ixoff
fi

# Completions
source ~/.config/bash/git-completion.bash

# Local
if [[ -r ~/.local/share/bash/interactive.bash ]]; then
    source ~/.local/share/bash/interactive.bash
fi

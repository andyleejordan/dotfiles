# this file is sourced by non-login interactive shells and ~/.bash_profile

# completions
source ~/.shell/git-completion.bash
__git_complete g _git

# cd options
shopt -s autocd cdspell dirspell

# glob options
shopt -s dotglob extglob globstar nocaseglob

# job options
shopt -s checkjobs huponexit

# shell options
shopt -s checkhash checkwinsize

# history
shopt -s cmdhist histappend histverify

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=2000

# prompt setup
PROMPT_DIRTRIM=2

source ~/.shell/git-prompt.sh
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

    # shortened working directory
    PS1+='\w '

    # add Git status with color hints
    PS1+="$(__git_ps1 "%s ")"

    # red for root, green for user
    if [[ $EUID == 0 ]]; then
	PS1+=$color_red
    else
	PS1+=$color_green
    fi

    # end of prompt
    PS1+='λ '
    PS1+=$color_off
}
PROMPT_COMMAND='set_prompt'

# uses 'thefuck' to fix common command mistakes
# https://github.com/nvbn/thefuck
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

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

# disable flow control
stty -ixon

# source everything else
source ~/.shell/common.sh

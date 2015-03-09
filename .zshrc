# allow Emacs Tramp to work
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
else
    # prezto
    prezto_init="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    [[ -s $prezto_init ]] && source $prezto_init

    # source common configuration
    source ~/.shrc

    # Zsh configuration
    limit coredumpsize 0
    setopt menu_complete
    setopt no_beep
fi

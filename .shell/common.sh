# this file is sourced by .bashrc and .zshrc

# path setup
source ~/.shell/path-edit.sh
path_front ~/bin /usr/local/sbin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin

# show a fortune
source ~/.shell/fortune.sh

# aliases
source ~/.shell/aliases.sh

# editor
EDITOR=vi

# alias v for editor if f(asd) is defined
if alias f &>/dev/null; then
  alias v="f -e $EDITOR"
  _fasd_bash_hook_cmd_complete v
else
  alias v="$EDITOR"
fi

# redirect old Emacs alias
alias e=v

# enable ls colors
if ls --color=auto &> /dev/null; then
    alias ls="ls --color=auto"
else
    export CLICOLOR=1
fi

# source everything else
source ~/.shell/local.sh

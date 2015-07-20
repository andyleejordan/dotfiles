## path
source ~/.shell/path-edit.sh
path_front ~/bin /usr/local/bin
path_back /sbin /bin /usr/sbin /usr/bin

## local settings
[[ -e ~/.shell/local.sh ]] && source ~/.shell/local.sh

## aliases
source ~/.shell/aliases.sh

## skip complicated setup for dumb shells
if [[ "$TERM" != "dumb" ]]
then
    ## pyenv
    command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
    command -v pyenv-virtualenv-init >/dev/null 2>&1 && eval "$(pyenv virtualenv-init -)"

    ## rbenv
    [[ -e ~/.rbenv ]] && eval "$(rbenv init -)"

    ## prompt
    [[ -e ~/.liquidprompt/ ]] && source ~/.liquidprompt/liquidprompt
fi

## assume colors work
export TERM=xterm-256color

## less options
export LESS='-g -i -M -R -S -w -z-4'

## assume colors work
export TERM=xterm-256color

## less options
export LESS='-g -i -M -R -S -w -z-4'

## path
source ~/.shell/path-edit.sh
path_front "bin" "$HOME/bin" "/usr/local/bin" "$HOME/.rbenv/bin"
path_back "/sbin" "/bin" "/usr/sbin" "/usr/bin" "$HOME/.cask/bin"

## aliases
source ~/.shell/aliases.sh

## local settings
[[ -e ~/.localrc ]] && source ~/.localrc

## pyenv
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
command -v pyenv-virtualenv-init >/dev/null 2>&1 && eval "$(pyenv virtualenv-init -)"

## rbenv
[[ -e ~/.rbenv ]] && eval "$(rbenv init -)"

## prompt
[[ -e ~/.liquidprompt/ ]] && source ~/.liquidprompt/liquidprompt

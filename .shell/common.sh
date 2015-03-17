## aliases
# misc
alias ping='ping -c 8'
alias root='sudo su'
alias cppc='cppcheck --std=c++11 --enable=all --suppress=missingIncludeSystem .'

if [[ $OSTYPE == darwin* ]]
then
    # power
    alias shutdown='sudo shutdown -hP now'
    alias reboot='sudo reboot now'
    alias sleep='shutdown -s now'

    # misc
    alias unlock_files='chflags -R nouchg *'

    ## editor
    EDITOR='ec -n "$@"'
elif [[ $OSTYPE == linux-gnu ]]
then
    # power
    alias shutdown='sudo shutdown -P now'
    alias reboot='sudo shutdown -r now'
    alias halt='sudo halt -P'

    ## editor
    ALTERNATE_EDITOR='nano'
    EDITOR="emacsclient -n"
fi

alias e=$EDITOR

# simplified package management
# pag - search
# par - auto-remove unused
# pcl - clean caches
# pdep - show dependencies
# pi - install
# pin - info
# pli - local install
# pr - remove
# pre - reinstall
# pu - show updates
# pup - install updates
alias pem='pushd ~/.emacs.d && cask update && popd'
if command -v brew >/dev/null 2>&1; then
    alias pag='brew search'
    alias par='echo "brew cannot auto-remove"'
    alias pcl='brew cleanup && brew prune'
    alias pdep='brew deps --tree'
    alias pi='brew install'
    alias pin='brew info'
    alias pli='brew install'
    alias pr='brew uninstall'
    alias pre='brew reinstall'
    alias pu='brew update && brew outdated'
    alias pup='brew update && brew upgrade'
elif command -v aptitude >/dev/null 2>&1; then
    alias pag='aptitude search'
    alias par='sudo apt-get autoremove'
    alias pcl='sudo aptitude clean'
    alias pdep='pin'
    alias pi='sudo aptitude install'
    alias pin='aptitude show'
    alias pli='sudo dpkg -i'
    alias pr='sudo aptitude purge'
    alias pre='sudo aptitude reinstall'
    alias pu='sudo aptitude update'
    alias pup='sudo aptitude update && sudo aptitude upgrade'
elif command -v apt-get >/dev/null 2>&1; then
    alias pag='apt-cache search'
    alias par='sudo apt-get autoremove'
    alias pcl='sudo apt-get clean'
    alias pdep='pin'
    alias pi='sudo apt-get install'
    alias pin='apt-cache show'
    alias pli='sudo dpkg -i'
    alias pr='sudo apt-get purge'
    alias pre='sudo apt-get install --reinstall'
    alias pu='sudo apt-get update'
    alias pup='sudo apt-get update && sudo apt-get upgrade'
elif command -v pacman >/dev/null 2>&1; then
    alias pag='pacman -Ss'
    alias pcl='sudo pacman -Sc'
    alias pi='sudo pacman -S'
    alias pin='pacman -Si'
    alias pli='sudo pacman -U'
    alias pr='sudo pacman -Rs'
    alias pu='sudo pacman -Sy'
    alias pup='sudo pacman -Syu'
elif command -v yum >/dev/null 2>&1; then
    alias pag='yum search'
    alias par='sudo yum autoremove'
    alias pcl='sudo yum clean'
    alias pdep='yum deplist'
    alias pi='sudo yum install'
    alias pin='yum info'
    alias pli='sudo rpm -i'
    alias pr='sudo yum remove'
    alias pre='sudo yum reinstall'
    alias pu='sudo yum update-to'
    alias pup='sudo yum update'
fi

## assume colors work
export TERM=xterm-256color

## less options
export LESS='-g -i -M -R -S -w -z-4'

## GitHub API
github_token="$HOME/.github"
[[ -e $github_token ]] && source $github_token

## homebrew GitHub API
homebrew_token="$HOME/.homebrew"
[[ -e $homebrew_token ]] && source $homebrew_token

## path
source ~/.path_edit.sh
path_front "bin" "$HOME/bin" "/usr/local/bin" "$HOME/.rbenv/bin"
path_back "/sbin" "/bin" "/usr/sbin" "/usr/bin" "$HOME/.cask/bin"

## pyenv
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
command -v pyenv-virtualenv-init >/dev/null 2>&1 && eval "$(pyenv virtualenv-init -)"

## local settings
[[ -e ~/.localrc ]] && source ~/.localrc

## use http://www.funtoo.org/Keychain

## rbenv
[[ -e ~/.rbenv ]] && eval "$(rbenv init -)"

## prompt
[[ -e ~/.liquidprompt/ ]] && source ~/.liquidprompt/liquidprompt

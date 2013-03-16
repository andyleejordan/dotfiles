# misc
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias ping='ping -c 5'
alias root='sudo su'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -hP now'
alias update-all='brew update && brew upgrade && upgrade_oh_my_zsh && vim +BundleUpdate +qall'

# ls
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ls -A'
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | less'

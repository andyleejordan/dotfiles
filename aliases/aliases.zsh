# misc
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias ping='ping -c 5'
alias root='sudo su'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -hP now'

# ls
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ls -A'
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | less'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias egrep='egrep --color=auto'
    alias ls='ls -h --color=auto'
    alias cp='cp -i'
    alias mv='mv -i'
    alias rm='rm -I'                    # 'rm -i' prompts for every file
    alias ln='ln -i'
    alias chown='chown --preserve-root'
    alias chmod='chmod --preserve-root'
    alias chgrp='chgrp --preserve-root'
    alias update-all='adg && vim +BundleUpdate +qall'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -h -G'
    alias unlock_files='chflags -R nouchg *'
    alias update-all='brew update && brew upgrade && vim +BundleUpdate +qall'
fi

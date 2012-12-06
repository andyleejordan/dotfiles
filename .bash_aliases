# aliases
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias ..='cd ..'
# Use alert like this: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias scat='sudo cat'
alias svim='sudo vim'
alias root='sudo su'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -hP now'
alias halt='sudo halt'
alias aupdate='sudo aptitude update && sudo aptitude upgrade'
alias ainstall='sudo aptitude install'
alias aremove='sudo aptitude purge'

# ls
alias ls='ls -h --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ls -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

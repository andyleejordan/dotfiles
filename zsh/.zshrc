# options
setopt AUTO_CD EXTENDED_GLOB MULTIOS CORRECT
setopt EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_SPACE

# aliases
alias g=git

# prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats ' [%F{green}%b%f]%F{green}%c%f%F{red}%u%f'
precmd () { vcs_info }
PS1='%(?..%F{magenta}%?%f )%(!.%F{red}%n%f.)%F{blue}@%f%m %F{blue}%5~%f${vcs_info_msg_0_}
%2(L.%F{green}%L%f .)%F{cyan}%#%f '

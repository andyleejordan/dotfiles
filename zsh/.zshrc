# homebrew
if command -v brew > /dev/null; then
  eval "$(brew shellenv)"
fi

# node
if command -v fnm > /dev/null; then
  eval "$(fnm env)"
fi

# options
setopt AUTO_CD EXTENDED_GLOB MULTIOS

# history options
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY

autoload -Uz compinit && compinit

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

# Wrap `copilot` so a bare invocation prompts before creating a new session.
# Routes through `agency copilot` when available, falls back to plain `copilot`.
copilot() {
  local -a cmd
  if command -v agency > /dev/null; then
    cmd=(agency copilot)
  else
    # avoid recursing into this function
    cmd=(command copilot)
  fi
  if [[ $# -eq 0 ]]; then
    printf "Start [n]ew session, [r]esume picker, [p]rompt, or [c]ontinue most recent? [n/r/p/c] "
    read -k 1 ans
    printf '\n'
    case "${ans:-c}" in
      n|N) "${cmd[@]}" ;;
      r|R) "${cmd[@]}" --resume ;;
      p|P)
        local prompt_val
        printf "Prompt: "
        read -r prompt_val
        "${cmd[@]}" --prompt "$prompt_val"
        ;;
      *)   "${cmd[@]}" --continue ;;
    esac
  else
    "${cmd[@]}" "$@"
  fi
}

# path
typeset -U path
path=(/opt/homebrew/bin $path ~/bin)

if command -v brew > /dev/null; then
  eval "$(brew shellenv)"
fi

# Rust
if [[ -f ~/.cargo/env ]]; then
  . ~/.cargo/env
fi

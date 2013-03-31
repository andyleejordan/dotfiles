plugins=(
    autojump
    extract
    fortune
    gem
    git
    history
    pip
    python
    ruby
    tmux
    url-tools
    vi-mode
    wakeonlan)

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(debian gnu-colors)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(brew osx)
fi

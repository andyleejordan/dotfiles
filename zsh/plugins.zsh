plugins=(
    autojump
    extract
    fortune
    git
    history
    pip
    python
    tmux
    url-tools
    vi-mode
    wakeonlan)

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(debian gnu-colors)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(brew osx)
fi

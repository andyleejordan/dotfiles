plugins=(
    autojump
    extract
    git
    history
    pip
    python
    url-tools
    vi-mode)

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(debian)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(brew osx)
fi

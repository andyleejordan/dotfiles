plugins=(
    extract
    fortune
    gem
    git
    history
    node
    pip
    python
    ruby
    ssh-agent
    tmux
    url-tools
    vi-mode
    wakeonlan
    virtualenvwrapper)

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(debian gnu-colors)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(brew osx)
fi

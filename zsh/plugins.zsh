plugins=(
    colored-man
    cp
    extract
    fortune
    gem
    git
    history
    pip
    python
    ssh-agent
    tmux
    url-tools
    vi-mode
    virtualenvwrapper
    vundle
    wakeonlan)

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(debian gnu-colors)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(brew copydir copyfile osx)
fi

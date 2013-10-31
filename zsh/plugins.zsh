plugins=(
    bower
    bundler
    cp
    extract
    fortune
    gem
    git
    gpg-agent
    heroku
    history-ag
    jump
    mercurial
    npm
    pip
    rsync
    themes
    vagrant
    virtualenv
    virtualenvwrapper
    wakeonlan)

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    plugins+=(debian)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(brew copydir copyfile osx)
fi

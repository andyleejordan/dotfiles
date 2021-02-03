#!/bin/sh
sudo apt-get install -y stow
for f in .bashrc .bash_profile .bash_logout; do
    if [ -e ~/$f ]; then
        mv ~/$f ~/$f.bak
    fi
done
stow --target="$HOME" --stow bash bin git powershell readline

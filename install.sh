#!/bin/sh

# Install GNU stow
if ! command -v stow >/dev/null @>&1; then
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get install -y stow
    elif command -v brew >/dev/null 2>&1; then
        brew install stow
    fi
fi

# Backup common existing files
for f in .bashrc .bash_profile .bash_logout; do
    if [ -e ~/$f ]; then
        mv ~/$f ~/$f.bak
    fi
done

# Stow dotfiles
stow --target="$HOME" --stow bash bin emacs git powershell readline

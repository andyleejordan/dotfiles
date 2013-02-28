#!/bin/sh
echo "Cloning my oh-my-zsh fork..."
git clone git@github.com:andschwa/oh-my-zsh.git ~/.oh-my-zsh
echo "Cloning my fresh fork..."
git clone git@github.com:andschwa/fresh.git ~/.fresh/source/freshshell/fresh
echo "Setting up fresh..."
ln -s ~/.dotfiles/fresh/freshrc ~/.freshrc
~/.fresh/source/freshshell/fresh/bin/fresh
echo "Cloning vundle for Vim..."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "Install Vim plugins..."
vim +BundleInstall +qall

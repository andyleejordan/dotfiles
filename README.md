.dotfiles
=========
Andrew Schwartzmeyer's terminal configurations.
-----------------------------------------------

This is my repository to hold my conf files and installation notes (for setting up new environments).

SUBMODULES: This has a submodule, .vim, which itself has submodules. Follow Git's [guide](http://git-scm.com/book/en/Git-Tools-Submodules) to understand these. Long story short, after cloning my .dotfiles repo, run these commands:

    cd ~/.dotfiles
    git submodule init
    git submodule update
    ln -s .tmux.conf ~/.tmux.conf
    ln -s dircolors-solarized/dircolors.ansi-dark ~/.dir_colors
    ln -s .gitconfig ~/.gitconfig
    ln -s .gitignore_global ~/.gitignore_global
    ln -s oh-my-zsh ~/.oh-my-zsh
    ln -s .zshrc ~/.zshrc

All files belong in home directory or relative path (personally I symlink them and have this directory as .dotfiles in home).

### Tmux
Tmux configuration is loosely based off that found in the Arch Linux wiki and Brandur's sample [.tmux.conf](https://github.com/brandur/tmux-extra), originally found on his [blog](https://mutelight.org/practical-tmux). Also added are vi like configurations, and the Solarized color scheme (NOTE: this requires the default terminal to be set, use xterm-256color).

### Git
Git configuration is simply my own ignore file and configuration file from using git for a while, NOTE: don't straight up copy .gitconfig, make sure you change your name.

### Setup
Programs
* zsh
* git
* vim
* tmux
* google-chrome
* jenkins
* nginx
* python
* python3
* powerline
* android-sdk-linux
* vmware-tools

Repos to clone
* dotfiles
* dotvim
* templates

Files to restore
* /etc/fstab
* /etc/nginx/sites-available/jenkins
* /etc/nginx/sites-available/default

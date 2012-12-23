.dotfiles
=====
# Andrew Schwartzmeyer's terminal configurations.

This is my repository to hold my conf files and installation notes (for setting up new environments).

SUBMODULES: This has a submodule, .vim, which itself has submodules. Follow Git's [guide](http://git-scm.com/book/en/Git-Tools-Submodules) to understand these. Long story short, after cloning my .dotfiles repo, run these commands:

    cd ~/.dotfiles
    git submodule init
    git submodule update
    ln -s .tmux.conf ~/.tmux.conf
    ln -s .bashrc ~/.bashrc
    ln -s .bashrc_aliases ~/.bashrc_aliases
    ln -s dircolors-solarized/dircolors.ansi-dark ~/.dir_colors
    ln -s .gitconfig ~/.gitconfig
    ln -s .gitignore_global ~/.gitignore_global
    ./gnome-terminal-colors-solarized/install.sh

All files belong in home directory or relative path (personally I symlink them and have this directory as .dotfiles in home).

## Tmux
Tmux configuration is loosely based off that found in the Arch Linux wiki and Brandur's sample [.tmux.conf](https://github.com/brandur/tmux-extra), originally found on his [blog](https://mutelight.org/practical-tmux). Also added are vi like configurations, and the Solarized color scheme (NOTE: this requires the default terminal to be set, use xterm-256color unless you make xterm-16color).

## Bash
This has my own PS1 configuration, a script to start/reattach to [tmux](https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login), and it calls the .bash\_aliases file, which has my custom aliases of course. The aliases have a lot from Arch Linux [wiki's aliases](https://wiki.archlinux.org/index.php/Bash#Aliases). It adds the current directory to the end of path (NOTE: this can be a big security issue, but is highly convenient as a programmer, so be very careful and only use this on trusting systems). It changes my TERM variable to xterm-16color, for the Solarized colors to work within tmux, but this generally has to be created, so use xterm-256color insteasd.  

## Git
Git configuration is simply my own ignore file and configuration file from using git for a while, NOTE: don't straight up copy .gitconfig, make sure you change your name.

prefs
=====
# Andrew Schwartzmeyer's terminal configurations.

This is my repository to hold my conf files and installation notes (for setting up new environments).

All files belong in home directory or relative path (personally I symlink them
and have this directory as .dotfiles in home).

## Vim
Vim configuration is loosely based off "[The Ultimate vimrc](https://github.com/amix/vimrc)" by [Amir Salihefendic](http://amix.dk), with some of his plugins. Also included is Fritz Mehner's [c.vim](http://www.vim.org/scripts/script.php?script_id=213), and Tim Pope's [vim-fugitive](https://github.com/tpope/vim-fugitive) plugins (actually this may have changed, just look in the directory). At some point I'll make these all submodules or something to keep them updated. They're located in .vim/bundle for Pathogen to infect them. Colors are courtesy of Ethan Schoonover's [Solarized](http://ethanschoonover.com/solarized).

## Tmux
Tmux configuration is loosely based off that found in the Arch Linux wiki and Brandur's sample [.tmux.conf](https://github.com/brandur/tmux-extra), originally found on his [blog](https://mutelight.org/practical-tmux). Also added are vi like configurations, and the Solarized color scheme.

## Bash
Bash configuration is based off the Arch Linux [wiki's aliases](https://wiki.archlinux.org/index.php/Bash#Aliases) (quite a few are Arch Linux only, dealing with pacman), with my own PS1 configuration, and a script to start/reattach to [tmux](https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login).

It calls the .bash_aliases file, which has my custom aliases of course.

## Git
Git configuration is simply my own ignore file and configuration file from using git for a small while. The bashrc file is sets up the git [bash completion](https://github.com/git/git/blob/master/contrib/completion/git-completion.bash).

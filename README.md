.dotfiles
=========
Andrew Schwartzmeyer's terminal configurations.
-----------------------------------------------

Here lives my dotfiles repo, for all my configuration files. It uses fresh to manage my customizations for Vim (using Vundle to manage the plugins), Zsh (using the oh-my-zsh framework and my own choice of plugins), [Powerline](https://github.com/Lokaltog/powerline) for the Zsh agnoster theme and Vim plugin (need to patch your fonts, follow lokaltog's docs), and other miscellaneous items.

After a major refactor and discovery of [fresh](https://github.com/freshshell/fresh), now you may just clone this repo and run the install script.

    git clone https://github.com/andschwa/dotfiles.git ~/.dotfiles
    ./install.sh

The install script will:
* Clone with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins) fork
* Clone my [fresh](https://github.com/freshshell/fresh) fork
* Run fresh to compile and symlink my dotfiles
* Clone the [Vundle](https://github.com/gmarik/vundle) plugin manager for Vim
* Install listed plugins from vimrc via Vundle

### Colors
My configuration depends _very_ heavily upon Ethan Schoonover's [Solarized](http://ethanschoonover.com/solarized) colorscheme. I did not include the terminal configurations for it as they are numerous. Very important point: you need xterm-256colors for your terminal environment (follow the docs). Here are the ones I've successfully used:
* [iTerm2](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)
* [Gnome Terminal](https://github.com/sigurdga/gnome-terminal-colors-solarized)
* [Xfce Terminal](https://github.com/sgerrand/xfce4-terminal-colors-solarized)
* [GNU dircolors](https://github.com/seebi/dircolors-solarized) (for `ls` colors)

### Git
NOTE: don't straight up use .gitconfig, make sure you change your name and email.

### Aliases
Due to the differences between OS X and GNU tools, for now just change the freshrc configuration to load the aliases you need.

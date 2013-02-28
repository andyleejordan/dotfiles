.dotfiles
=========
Andrew Schwartzmeyer's terminal configurations.
-----------------------------------------------

After a major refactor and discovery of [fresh](https://github.com/freshshell/fresh), clone this repo and run the install script.

    git clone https://github.com/andschwa/dotfiles.git ~/.dotfiles
    ./install.sh

The install script will:
* Clone with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins) fork
* Clone my [fresh](https://github.com/freshshell/fresh) fork
* Run fresh to compile and symlink my dotfiles
* Clone the [Vundle](https://github.com/gmarik/vundle) plugin manager for Vim
* Install listed plugins from vimrc via Vundle

### Git
NOTE: don't straight up use .gitconfig, make sure you change your name and email.

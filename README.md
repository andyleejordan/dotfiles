# andschwa's dotfiles

Uses Git [subtree][] and submodules to keep my dotfiles in one place
in an elegant manner. With inspiration from [xero][], uses [GNU Stow][]
to symlink files one folder deep to the folder above.

This is the third generation of my [dotfiles][] management system. It is a
weird hobby of mine, but I am not alone! The others hang out at [vcs-home][].

[subtree]: https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt
[xero]: https://github.com/xero/dotfiles
[GNU Stow]: https://www.gnu.org/software/stow/
[dotfiles]: https://dotfiles.github.io/
[vcs-home]: https://vcs-home.branchable.com/

# tools

Other tools to install:

- [GNU Emacs](https://github.com/andschwa/.emacs.d): best everything
- [ripgrep](https://github.com/BurntSushi/ripgrep): best grep
- [fish](https://fishshell.com/): best shell
- [Git](https://git-scm.com/) (and [hub](https://hub.github.com/)): best VCS
- [The Fuck](https://github.com/nvbn/thefuck): best fuck-up fixer
- [tmux](https://github.com/tmux/tmux): best terminal multiplexer
- [Firefox](https://www.mozilla.org/en-US/firefox/): best browser
- [Solarized](http://ethanschoonover.com/solarized): best color theme

# deprecations

Previously I have used [freshrc][] to manage my dotfiles (the history of which
is in the shell subtree). It was too complicated. Then I switched to a
combination of [vcsh][] and [myrepos][], which added a lot of overhead.
Specifically, I did not like that the files didn't exist in a Git repository,
which broke VCS integration with my editors. After an erroneous `vcsh foreach
git fetch` was auto-corrected to `vcsh foreach init` and broke my local repos,
I realized I needed just one repo.

I've also swapped between both Vim and Emacs several times. If I
remember correctly, I started with Vim, was convinced to try Emacs by
my mentor, fell in love with Elisp, never quite liked the key-chording
and went back to Vim, hated VimL, used [Spacemacs][] for a time, and now
have taken to using my own integrations of Evil (Vim-mode) with Emacs.

I still recommend Spacemacs to new users, as it's the best of both
worlds. I just found the one-size-fits-all approach too clunky for me,
since I heavily customize my editor anyway.

[freshrc]: https://github.com/freshshell/fresh
[vcsh]: https://github.com/RichiH/vcsh
[myrepos]: https://myrepos.branchable.com/
[spacemacs]: http://spacemacs.org/

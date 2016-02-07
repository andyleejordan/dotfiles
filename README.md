# andschwa's dotfiles

Uses Git [subtree][] to keep my dotfiles in one place in an elegant manner.
With inspiration from [xero][], uses [GNU Stow][] to symlink files one folder
deep to the folder above.

This is the third generation of my [dotfiles][] management system. It is a
weird hobby of mine, but I am not alone! The others hang out at [vcs-home][].

[subtree]: https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt
[xero]: https://github.com/xero/dotfiles
[GNU Stow]: https://www.gnu.org/software/stow/
[dotfiles]: https://dotfiles.github.io/
[vcs-home]: https://vcs-home.branchable.com/

# deprecations

Previously I have used [freshrc][] to manage my dotfiles (the history of which
is in the shell subtree). It was too complicated. Then I switched to a
combination of [vcsh][] and [myrepos][], which added a lot of overhead.
Specifically, I did not like that the files didn't exist in a Git repository,
which broke VCS integration with my editors. After an erroneous `vcsh foreach
git fetch` was auto-corrected to `vcsh foreach init` and broke my local repos,
I realized I needed just one repo.

[freshrc]: https://github.com/freshshell/fresh
[vcsh]: https://github.com/RichiH/vcsh
[myrepos]: https://myrepos.branchable.com/

# Andy's dotfiles

Uses Git [subtree][] and submodules to keep my dotfiles in one place
in an elegant manner. With inspiration from [xero][], uses [GNU Stow][]
to symlink files one folder deep to the folder above.

These settings sync across machines. Some configurations guard optional tools
that may not be installed everywhere.

This is the third generation of my [dotfiles][] management system. It is a
weird hobby of mine, but I am not alone! The others hang out at [vcs-home][].

[subtree]: https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt
[xero]: https://github.com/xero/dotfiles
[GNU Stow]: https://www.gnu.org/software/stow/
[dotfiles]: https://dotfiles.github.io/
[vcs-home]: https://vcs-home.branchable.com/

## Tools

Other tools to install:

- [GNU Emacs](https://github.com/andschwa/.emacs.d): best everything
- [ripgrep](https://github.com/BurntSushi/ripgrep): best grep
- [Git](https://git-scm.com/)): best VCS
- [Solarized](http://ethanschoonover.com/solarized): best color theme

## Zsh

The installer installs two complementary plugins when Homebrew is available,
skipping each one if already installed:

```sh
./install.sh
```

- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
  automatically shows completion menus for commands, options, and paths.
  Press Tab to insert the first completion, Down Arrow to browse the menu,
  or Up Arrow to search history.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  shows gray inline suggestions from shell history, such as
  `brew update && brew upgrade`. Press Right Arrow at the end of the line
  to accept one, or keep typing to ignore it.

`cd` commands are excluded from gray history suggestions, so directory
navigation uses completion in the current location instead of replaying
paths from somewhere else. Both plugins run locally; neither uses an AI
service or credits.

`.zshrc` loads autocomplete first and lets it initialize Zsh's completion
system, then loads autosuggestions with history-only suggestions. Each
plugin is optional; without autocomplete, `.zshrc` initializes normal Tab
completion instead. Autocomplete's recent directories are stored under
`${XDG_DATA_HOME:-$HOME/.local/share}/zsh`.

## Homebrew

On a Mac with Homebrew under `/opt/homebrew`, the installer loads
`local.upgradebrew`, a launch agent that runs `brew upgrade --no-ask` daily at
10 AM, or on the next wake if the Mac was asleep, logging to
`~/Library/Logs/upgrade-brew.log`. launchd can't expand `~` in a plist, so
`install.sh` writes [`launchd/local.upgradebrew.plist`](launchd/local.upgradebrew.plist)
into `~/Library/LaunchAgents` with the home directory filled in; rerun it
after editing the template.

## Windows

Yes, I use much of this on Windows too (I work at Microsoft after all).
But instead of using GNU Stow, I just load things from stubs.
Usually I clone this repo to `~/src/dotfiles` because Windows is messy.

### PowerShell

In `$PROFILE.CurrentUserAllHosts`:

```pwsh
. ~/src/dotfiles/powershell/.config/powershell/profile.ps1
```

### Git

In `~/.gitconfig`:

```config
[include]
    path = src/dotfiles/git/.config/git/config
```

## Deprecations

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

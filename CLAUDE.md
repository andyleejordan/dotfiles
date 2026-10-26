# dotfiles

`install.sh` stows each package directory into `~`, so never add files to a
package that shouldn't land in the home directory.

Every link from `~` into this repo belongs to Stow. Create or repair one only
by running `install.sh`, never with `ln`, even after moving the repo: then
remove the dead links the old location left and rerun it. Stow won't touch a
link it didn't make, and one such link stops the whole install; links an
agent rebuilt by hand after the move from `~/.dotfiles` did that for six
weeks. Keep `~/.config` a real directory, never a link: when it's missing,
Stow links the whole folder into one package, and every app then writes its
data into the repo.

## zsh

`.zshenv` sets PATH only (`typeset -U path`, `~/.local/bin` included) and runs
no subprocesses, because zsh sources it for every script, not just
interactive shells. `brew shellenv`, `fnm env`, and other interactive setup
live in `.zshrc`; moving them there took script startup from about 24 ms to
2.7 ms. Lowercase `path` is tied to `PATH` in zsh, so never use it as an
ordinary variable: a script that assigned to it once wiped PATH.

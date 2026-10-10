# dotfiles

`install.sh` stows each package directory into `~`, so never add files to a
package that shouldn't land in the home directory.

## zsh

`.zshenv` sets PATH only (`typeset -U path`, `~/.local/bin` included) and runs
no subprocesses, because zsh sources it for every script, not just
interactive shells. `brew shellenv`, `fnm env`, and other interactive setup
live in `.zshrc`; moving them there took script startup from about 24 ms to
2.7 ms. Lowercase `path` is tied to `PATH` in zsh, so never use it as an
ordinary variable: a script that assigned to it once wiped PATH.

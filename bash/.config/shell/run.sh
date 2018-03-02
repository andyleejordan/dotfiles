# Copyright 2016 Andrew Schwartzmeyer

# run is a function that enables bash completion of commands in folders that
# should not exist in PATH for security reasons, but are very convenient; so
# with run, these are added to the PATH explicitly and temporarily

# prepend local . and bin folders for commands
_RUN_PATH=".:bin:$PATH"

# generate completions with the extended PATH
_run() {
  PATH=$_RUN_PATH
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -c -- $cur))
}

# eval commands with the extended PATH
run() {
  PATH=$_RUN_PATH eval "$@"
}

complete -F _run run

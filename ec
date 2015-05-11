#!/bin/bash
# Copyright 2015 Andrew Schwartzmeyer

# Opens Emacs app on OS X if required, else uses emacsclient

# Add the following (or similar) to shell profile
# EDITOR=ec
# alias e="$EDITOR -n" (no wait)

# Add "(server-start)" to end of Emacs initialization

set -eu
server=/tmp/emacs501/server # C-h v server-socket-dir
if [[ -e $server ]]; then
    emacsclient -s $server "$@"
else
    open -a ~/Applications/Emacs.app
    ec "$@"
fi

#!/bin/bash
# Copyright 2015 Andrew Schwartzmeyer
set -eu
server=/tmp/emacs501/server
if [[ -e $server ]]; then
    emacsclient -s $server "$@"
else
    open -a /Applications/Emacs.app "$@"
fi

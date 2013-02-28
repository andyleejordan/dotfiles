if type tmux &> /dev/null; then
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

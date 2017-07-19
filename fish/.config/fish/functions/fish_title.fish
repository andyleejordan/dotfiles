function fish_title
  # $argv is always the last command, but fish_title is called before and after
  # the command executes, so this conditional uses just the pwd
  if test $_ = "fish"
    set title (prompt_pwd)
  else
    set title (prompt_pwd) $argv
  end
  test -n "$TMUX"; and tmux rename-window "$title"
  echo $title
end

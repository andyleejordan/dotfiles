function fish_prompt
  # save the status before overwriting it
	set last_status $status

  # used to color the prefix and postfix parens
  set color_parens (set_color green)

  set prefix $color_parens '('

  # this uses a cached hostname to avoid DNS hiccups
  set host (set_color blue) '@' (set_color normal) (prompt_hostname)

  if test $last_status -ne 0
    set status_code (set_color purple) ' ' $last_status
  end

  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showupstream auto
  set -g __fish_git_prompt_describe_style branch
  set -g __fish_git_prompt_showcolorhints true
  set vcs (__fish_vcs_prompt) # this has a prefixed space

  # this uses a special shortened path
  set cwd (set_color normal) ' ' (prompt_pwd)

  set postfix $color_parens ') '

  # echo without newline or extra spaces
  echo -n -s $prefix $host $status_code $vcs $cwd $postfix
end

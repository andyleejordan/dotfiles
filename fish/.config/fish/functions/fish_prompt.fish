function fish_prompt
  # save the status before overwriting it
  set last_status $status

  # this uses a cached hostname to avoid DNS hiccups
  set host (set_color blue) '@' (set_color normal) (prompt_hostname)

  # only print non-zero exit codes
  if test $last_status -ne 0
    set status_code ' ' (set_color purple) $last_status (set_color normal)
  end

  # configure git info
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showupstream auto
  set -g __fish_git_prompt_describe_style branch
  set -g __fish_git_prompt_showcolorhints true
  set vcs (__fish_vcs_prompt) # this has a prefixed space

  # increase max path component length
  set -g fish_prompt_pwd_dir_length 5
  set cwd ' ' (set_color blue) (prompt_pwd) (set_color normal)

  # echo without newline or extra spaces, but interpret escapes
  echo -n -s -e $host $status_code $vcs $cwd '\n> '
end

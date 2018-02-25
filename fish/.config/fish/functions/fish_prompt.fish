function fish_prompt
  # save the status before overwriting it
  set last_status $status

  # only print non-zero exit codes
  if test $last_status -ne 0
    set status_code (set_color magenta) $last_status (set_color normal) ' '
  end


  # red root user
  if test (id -u) -eq 0
    set user_color red
  else
    set user_color normal
  end
  set user (set_color $user_color) (whoami) (set_color normal)

  # this uses a cached hostname to avoid DNS hiccups
  set host (set_color blue) '@' (set_color normal) (prompt_hostname)

  # configure git info
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showupstream auto
  set -g __fish_git_prompt_describe_style branch
  set -g __fish_git_prompt_showcolorhints true
  set vcs (__fish_vcs_prompt) # this has a prefixed space

  # increase max path component length
  set -g fish_prompt_pwd_dir_length 5
  set cwd ' ' (set_color blue) (prompt_pwd) (set_color normal)

  set postfix '\n' (set_color cyan) '>' (set_color normal) ' '

  # echo without newline or extra spaces, but interpret escapes
  echo -n -s -e $status_code $user $host $vcs $cwd $postfix
end

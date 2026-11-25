# Keep path editing literal: directory names can contain spaces and patterns.
_path_edit() {
  local side=$1 dir remaining entry cleaned added=
  shift
  for dir; do
    cleaned=
    remaining=${PATH-}
    while [[ -n $remaining ]]; do
      entry=${remaining%%:*}
      case $remaining in
      *:*) remaining=${remaining#*:} ;;
      *) remaining= ;;
      esac
      if [[ -n $entry && $entry != "$dir" ]]; then
        cleaned=${cleaned:+$cleaned:}$entry
      fi
    done
    PATH=$cleaned
    if [[ -d $dir ]]; then
      case :$added: in
      *:"$dir":*) ;;
      *) added=${added:+$added:}$dir ;;
      esac
    fi
  done
  if [[ $side == front ]]; then
    PATH=${added}${added:+${PATH:+:}}$PATH
  else
    PATH=${PATH}${PATH:+${added:+:}}$added
  fi
  export PATH
}

path_front() {
  _path_edit front "$@"
}

path_back() {
  _path_edit back "$@"
}

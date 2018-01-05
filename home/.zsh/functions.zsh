# ~/.zsh/functions.zsh

# lifted from oh-my-zsh
function take() {
  mkdir -p $1
  cd $1
}

# acts like cat on files, and like ls on directories
function cls() {
  emulate -L zsh
  if [[ $# -eq 0 ]]; then
    ls
  elif [[ $# -eq 1 ]]; then
    [[ -f $1 ]] && cat "$1" || ls "$1"
  else
    for entry in "$@"; do
      echo "==> $entry <=="
      cls "$entry"
      echo
    done
  fi
}

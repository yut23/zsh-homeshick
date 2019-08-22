# ~/.zsh/functions.zsh

# lifted from oh-my-zsh
function take() {
  mkdir -p $1
  cd $1
}

# acts like cat on files, and like ls on directories
function cls() {
  emulate -L zsh
  if [[ $# -gt 1 && $1 == '-l' ]]; then
    ls_args=$1
    shift
  fi
  if [[ $# -eq 0 ]]; then
    ls $ls_args
  elif [[ $# -eq 1 ]]; then
    [[ -f $1 ]] && cat "$1" || ls $ls_args "$1"
  else
    for entry in "$@"; do
      echo "==> $entry <=="
      cls $ls_args "$entry"
      echo
    done
  fi
}

function total_mem() {
  pgrep "$@" | xargs -i cat /proc/{}/statm | cut -d' ' -f2 | awk '{pages += $1}; END {printf("%d\n", pages*4096)}' | numfmt --to=iec --suffix=B --format=%.2f
}

function activate() {
  VIRTUAL_ENV_DISABLE_PROMPT='1' source ./$1/bin/activate
}

function pull-changes() {
  git fetch
  git rebase origin master
}

# zsh-grml adds a mostly-broken translate function, which shadows the "trans"
# command from translate-shell.
if [[ $(whence -w trans) == 'trans: function' ]]; then
  unfunction trans
fi

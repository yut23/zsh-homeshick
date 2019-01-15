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

function total_mem() {
  pgrep "$@" | xargs -i cat /proc/{}/statm | cut -d' ' -f2 | awk '{pages += $1}; END {printf("%d\n", pages*4096)}' | numfmt --to=iec --suffix=B --format=%.2f
}

function activate() {
  VIRTUAL_ENV_DISABLE_PROMPT='1' source ./$1/bin/activate
}

# zsh-grml adds a mostly-broken translate function, which shadows the "trans"
# command from translate-shell.
unfunction trans

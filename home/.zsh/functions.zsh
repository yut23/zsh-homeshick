# ~/.zsh/functions.zsh

# lifted from oh-my-zsh
function take() {
  mkdir -p $1
  cd $1
}

# acts like cat on files, and like ls on directories
function cls() {
  emulate -L zsh
  local -a ls_args cat_args files
  while [[ $# -gt 0 ]]; do
    local arg="$1"
    case "$1" in
      -n|--show-all|--number-nonblank|--show-ends|--number|--squeeze-blank|--show-tabs|--show-nonprinting)
        cat_args+=("$1")
        ;;
      --)
        shift  # remove --
        break  # exit while loop
        ;;
      -?*)
        ls_args+=("$1")
        ;;
      *)
        files+=("$1")
        ;;
    esac
    shift
  done
  # restore file parameters
  set -- "${files[@]}" "$@"

  if [[ $# -eq 0 ]]; then
    ls "${ls_args[@]}"
  elif [[ $# -eq 1 ]]; then
    [[ -f $1 ]] && cat "${cat_args[@]}" "$1" || ls "${ls_args[@]}" "$1"
  else
    for entry in "$@"; do
      echo "==> $entry <=="
      cls "${ls_args[@]}" "${cat_args[@]}" "$entry"
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

function dumpenv() {
  tr '\000' $'\n' < /proc/$(pidof "$*")/environ
}

# zsh-grml adds a mostly-broken translate function, which shadows the "trans"
# command from translate-shell.
if [[ $(whence -w trans) == 'trans: function' ]]; then
  unfunction trans
fi

function clear-swap() {
  sudo /usr/local/bin/deswappify
  if command free -b | awk '/Mem:/ { free=$4 } /Swap:/ { swap=$3 } END { exit !(free-swap>0) }'; then
    sudo swapoff -a && sudo swapon -a
  else
    echo Not enough free memory to clear swap
  fi
}

function remove-evince-metadata() {
  for file in "$@"; do
    while read attribute value; do
      [[ "${attribute:0:18}" == "metadata::evince::" ]] && gio set -t unset "$file" "${attribute:0:-1}"
    done < <(gio info -a metadata "$file")
  done
}

if (( $+commands[xprop] && $+commands[obxprop] )); then
  # obxprop is worse than xprop, so alias it to something useful
  function obxprop() {
    command xprop -notype $@ | sed -n 's/^_OB_APP_//p'
  }
fi

function find_tmux() {
  emulate -L zsh
  local -a hosts
  if [[ $system_name == summit ]]; then
    hosts=(login{1..5})
  elif [[ $system_name == cori ]]; then
    hosts=(cori{01..23})
  fi
  local h
  for h in "${hosts[@]}"; do
    # exclude $HOSTNAME, if we're currently in tmux
    if [[ $h == $HOSTNAME && -n ${TMUX_SSH+x} ]]; then
      continue
    fi
    if ssh "$h" =tmux ls -F '\#{session_name}' 2>/dev/null | grep '^ssh-'"$USER"'$' &>/dev/null; then
      echo "$h"
    fi
  done
}

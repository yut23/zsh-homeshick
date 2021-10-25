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
    case "$1" in
      -n|-v|--show-all|--number-nonblank|--show-ends|--number|--squeeze-blank|--show-tabs|--show-nonprinting)
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
    if [[ -f $1 ]]; then
      cat "${cat_args[@]}" -- "$1"
    else
      ls "${ls_args[@]}" -- "$1"
    fi
  else
    for entry in "$@"; do
      local sign=""
      if [[ -d "$entry" ]]; then
        sign="/"
      fi
      echo "==> $entry$sign <=="
      cls "${ls_args[@]}" "${cat_args[@]}" -- "$entry"
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

if [[ -e /usr/local/bin/deswappify ]]; then
  function clear-swap() {
    sudo /usr/local/bin/deswappify
    if command free -b | awk '/Mem:/ { free=$4 } /Swap:/ { swap=$3 } END { exit !(free-swap>0) }'; then
      sudo swapoff -a && sudo swapon -a
    else
      echo Not enough free memory to clear swap
    fi
  }
fi

function remove-evince-metadata() {
  for file in "$@"; do
    while read attribute value; do
      [[ "${attribute:0:18}" == "metadata::evince::" ]] && gio set -t unset "$file" "${attribute:0:-1}"
    done < <(gio info -a metadata "$file")
  done
}

if (( $+commands[xprop] && $+commands[obxprop] )); then
  # obxprop is worse than xprop, so just make it a wrapper around xprop
  function obxprop() {
    command xprop -notype $@ | sed -n 's/^_OB_APP_//p'
  }
  compdef obxprop=xprop
fi

function find_tmux() {
  emulate -LR zsh
  local -a hosts
  local tmux_cmd
  tmux_cmd=tmux
  if (( $+commands[tmux] )); then
    tmux_cmd==tmux
  fi
  if [[ "$1" == perlmutter ]]; then
    # this only works from cori or dtn, since the login nodes don't have
    # host-based authentication set up
    hosts=(login{01..40}.perlmutter.nersc.gov)
    tmux_cmd=tmux
  elif [[ $system_name == summit ]]; then
    hosts=(login{1..5})
  elif [[ $system_name == andes ]]; then
    hosts=(andes-login{1..8})
  elif [[ $system_name == cori ]]; then
    hosts=(cori{01..23})
  elif [[ $system_name == olcf-dtn ]]; then
    hosts=(dtn{35..38})
  fi
  # exclude $HOSTNAME, if we're currently in tmux
  if [[ -n ${TMUX_SSH+x} ]]; then
    hosts=("${hosts[@]:#$HOSTNAME}")
  fi
  local -a ssh_cmd
  ssh_cmd=(sh -c "ssh '{}' '$tmux_cmd' has-session -t '\\=ssh-$USER' &>/dev/null && echo '{}' || true")
  print -N "${hosts[@]}" | xargs -0 -I '{}' -n 1 -P 4 "${ssh_cmd[@]}"
}

function read_ctlseq() {
  local output
  local char
  printf "$@"
  if read -s -t 0.1 -k char; then
    output="$output$char"
    while read -s -t -k char; do
      output="$output$char"
    done
    printf '%s' "${(V)output}"
  else
    echo 'No response from terminal'
  fi
  REPLY="$output"
}

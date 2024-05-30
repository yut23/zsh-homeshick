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
  # toggling alias expansion on and off doesn't work inside a function, so parse any aliases beforehand
  local -a ls_alias cat_alias
  ls_alias=(${(@Qz)"$(alias ls)"#ls=}) || ls_alias=(ls)
  cat_alias=(${(@Qz)"$(alias cat)"#cat=}) || cat_alias=(cat)
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
    "${ls_alias[@]}" "${ls_args[@]}"
  elif [[ $# -eq 1 ]]; then
    if [[ -f $1 ]]; then
      "${cat_alias[@]}" "${cat_args[@]}" -- "$1"
    else
      "${ls_alias[@]}" "${ls_args[@]}" -- "$1"
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
  local PAGESIZE=$(getconf PAGESIZE)
  # field 2 of statm is the number of resident pages
  pgrep "$@" |
    xargs -i cat /proc/{}/statm |
    awk -v PAGESIZE=$PAGESIZE '{pages += $2}; END {printf("%d\n", pages*PAGESIZE)}' |
    numfmt --to=iec --suffix=B --format=%.2f
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
  if [[ $system_name == perlmutter ]]; then
    hosts=(login{01..40})
  elif [[ $system_name == summit ]]; then
    hosts=(login{1..5})
  elif [[ $system_name == frontier ]]; then
    # see /etc/ssh/shosts.equiv
    hosts=(login{01..16})
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
  print -N "${hosts[@]}" | xargs -0 -I '{}' -n 1 "${ssh_cmd[@]}"
}

function read_ctlseq() {
  local output
  local char
  printf "$@"
  # wait for up to 0.1 seconds to get a response from the terminal
  if read -s -t 0.1 -k char; then
    output="$output$char"
    # read all characters from the input buffer (non-blocking)
    while read -s -t 0 -k char; do
      output="$output$char"
    done
    printf '%s' "${(V)output}"
  else
    echo 'No response from terminal'
  fi
  REPLY="$output"
}

function read_raw_input() {
  local output
  local char
  # this will block until a character is read, unless `-t <num>` is passed
  if read -s -k "$@" char; then
    output="$output$char"
    # read all characters from the input buffer (non-blocking)
    while read -s -t 0 -k char; do
      output="$output$char"
    done
    printf '%s\n' "${(V)output}"
  else
    echo 'No input was read'
  fi
  REPLY="$output"
}

if [[ $system_name == (summit|frontier|andes|olcf-dtn) ]]; then
  function missing_plots() (
    if [[ $# -eq 1 ]]; then
      cd -q $1 2>/dev/null || true
    fi
    if [[ ${PWD:t} != run* ]]; then
      print -ru2 'Error: not in a directory named run*'
      return 1
    fi
    local suffix=${${PWD:t}#run}
    cd -q "../analysis$suffix" 2>/dev/null || true
    {
      find ../run$suffix -maxdepth 1 -type d \( -name *plt* -a \! -name *plt*.old.* -a \! -name *plt*.temp \)
      if [[ -d ../run$suffix/plotfiles ]]; then
        find ../run$suffix/plotfiles -maxdepth 1 -type d \( -name *plt* -a \! -name *plt*.old.* \)
      fi
    } | while read -r plotfile; do
      if [[ -e "${plotfile:t}_slice.png" ]] || [[ -e "${plotfile:t}_enuc_annotated_top.png" ]]; then
        continue
      fi
      echo "${plotfile:t}"
    done | sort
  )
fi

if [[ -e ~/submit/run_backup.zsh ]]; then
  alias run_backup=$HOME/submit/run_backup.zsh
  if (( $+commands[bsub] )); then
    function bsub() {
      if [[ $# -ge 1 && -e "${@[$#]}" ]]; then
        ~/submit/run_backup.zsh -m "automatic backup for \"bsub $*\" on $system_name" "${@[$#]}"
      fi
      command bsub "$@"
    }
  fi
  if (( $+commands[sbatch] )); then
    function sbatch() {
      if [[ $# -ge 1 && -e "${@[$#]}" ]]; then
        ~/submit/run_backup.zsh -m "automatic backup for \"sbatch $*\" on $system_name" "${@[$#]}"
      fi
      command sbatch "$@"
    }
  fi
fi

# takes absolute paths on stdin and transforms any under the current directory
# into relative paths (others are left unchanged)
function make_relative() {
  local line
  local pwd=${PWD%/}/
  while read -r line; do
    if [[ $line[1] == / ]] && [[ ${line#$pwd} != $line ]]; then
      line="./${line#$pwd}"
    fi
    print -r "$line"
  done
}

# fix __vte_prompt_command so it works in zsh, and disable setting the title
if (( $+functions[__vte_prompt_command] )); then
  unfunction __vte_prompt_command
  function __vte_prompt_command() {
    # semicolons are used as separators in OSC-777, so replace them with spaces
    printf '\033]777;notify;Command completed;%s\033\\\033]777;precmd\033\\' "${$(fc -ln -1)//;/ }"
  }
  #add-zsh-hook precmd __vte_prompt_command
fi

# run a command and don't report the time it took
function noreporttime {
  local REPORTTIME=-1
  "$@"
}
# enable tab completion for wrapped commands
compdef _precommand noreporttime

function stop-zinit-scheduler() {
  add-zsh-hook -d chpwd @zinit-scheduler
  local keep_going=1
  local i
  while (( keep_going )); do
    keep_going=0
    for ((i = 1; i <= $#zsh_scheduled_events; ++i)); do
      # events look like <scheduled timestamp>:<options>:<command>
      # here <command> has colons, so skip the first 2 fields and rejoin the rest
      if [[ ${(j.:.)${(s.:.)zsh_scheduled_events[i]}[2,-1]} == 'ZINIT[lro-data]="$_:$?:${options[printexitvalue]}"; @zinit-scheduler following "${ZINIT[lro-data]%:*:*}"' ]]; then
        sched "-$i"
        keep_going=1
        break
      fi
    done
  done
}

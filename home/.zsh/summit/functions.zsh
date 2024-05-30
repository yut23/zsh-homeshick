# ~/.zsh/summit/functions.zsh

# wrapper that reads the new job ID and stores it in $last_job
function bsub_wrapper() {
  emulate -LR zsh
  local myfd output exit_code
  exec {myfd}>&1
  output=$(command bsub "$@" >&1 >&$myfd)
  exit_code=$?
  exec {myfd}>&-
  if [[ $output =~ "^Job <([0-9]+)> is submitted" ]]; then
    printf 'Setting $last_job to %d\n' "$match[1]"
    export last_job=$match[1]
  fi
  return $exit_code
}

function bslots() {
  emulate -LR zsh
  local -a lines
  lines=("${(@f)$(command bslots "$@")}")
  printf '%s\n' "${lines[1]/SLOTS/NODES}"
  local line slots
  for line in ${lines[2,-1]}; do
    slots=${line%% *}
    printf '%-*d%s\n' $#slots $(($slots / 42)) "${line:$#slots}"
  done
}

alias hsi=hsi_wrapper
function hsi_wrapper() {
  # canonicalize paths, so we can do a proper prefix match
  local real_pwd=${PWD:A}
  local real_scratch=${SCRATCH:A}
  local subdir=${real_pwd#${real_scratch}/}

  local hpss_root=/hpss/prod/$PROJID/users/$USER
  local feed_str="cdls $hpss_root"
  if [[ $subdir != $real_pwd ]]; then
    feed_str="cd $hpss_root"$'\n'"cdls $subdir"
  fi
  #feed_str="cd $hpss_root"$'\n'"cdls flame_wave/aprox19_hot_dense"
  ptypipe $feed_str hsi "$@"
}

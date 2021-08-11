# ~/.zsh/summit/functions.zsh

# wrapper that reads the new job ID and stores it in $last_job
bsub_wrapper() {
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
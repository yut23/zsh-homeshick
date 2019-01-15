# source-ssh-agent: Script to source for ssh-agent to work.

# Check if accidentaly executed instead of sourced:
sourced=0
if [ -n "$ZSH_EVAL_CONTEXT" ]; then
  case $ZSH_EVAL_CONTEXT in *:file) sourced=1;; esac
elif [ -n "$KSH_VERSION" ]; then
  [ "$(cd "$(dirname -- "$0")" && pwd -P)/$(basename -- "$0")" != "$(cd "$(dirname -- "${.sh.file}")" && pwd -P)/$(basename -- "${.sh.file}")" ] && sourced=1
elif [ -n "$BASH_VERSION" ]; then
  (return 2>/dev/null) && sourced=1
else # All other shells: examine $0 for known shell binary filenames
  # Detects `sh` and `dash`; add additional shell filenames as needed.
  case ${0##*/} in sh|dash) sourced=1;; esac
fi
if [ $sourced = 0 ]; then
  echo "source-ssh-agent: Do not execute directly - source me instead!"
  return 1 2>/dev/null || exit 1
fi

export SSH_AUTH_SOCK=$PREFIX/tmp/ssh-agent

start_agent () {
  rm -f "$SSH_AUTH_SOCK"
  ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
  ssh-add
}

MESSAGE=$(ssh-add -L 2>&1)
if [ "$MESSAGE" = 'Could not open a connection to your authentication agent.' ] || \
  [ "$MESSAGE" = 'Error connecting to agent: Connection refused' ] || \
  [ "$MESSAGE" = 'Error connecting to agent: No such file or directory' ]; then
  start_agent
elif [ "$MESSAGE" = "The agent has no identities." ]; then
  ssh-add
fi

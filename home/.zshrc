#!/bin/zsh
# ~/.zshrc

# If in ssh, get into tmux ASAP
if [[ -f "$HOME/.zsh/tmux.zsh" ]]; then
  source "$HOME/.zsh/tmux.zsh"
fi

# set hostname
export HOSTNAME=$(hostname)

source "$HOME/.zsh/paths.zsh"

# Disable coredumps
ulimit -c 0

# Detect terminal emulator
if [[ -z "${TEMU}" ]]; then
  TEMU=$(basename $(ps -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))
  if [[ $TEMU =~ gnome-terminal ]]; then
    TEMU=gnome-terminal
  fi
  export TEMU
fi

source "${HOME}/.zsh/zshrc"

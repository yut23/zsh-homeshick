#!/bin/zsh
# ~/.zshrc

# If in ssh, get into tmux ASAP
if [[ -f "$HOME/.zsh/tmux.zsh" ]]; then
  source "$HOME/.zsh/tmux.zsh"
fi

source "$HOME/.zsh/paths.zsh"

# Disable coredumps
ulimit -c 0

# Set editor
export EDITOR=vim

# Detect terminal emulator
if [[ -z "${TEMU}" ]]; then
  TEMU=$(basename $(ps -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))
  if [[ $TEMU =~ gnome-terminal ]]; then
    TEMU=gnome-terminal
  fi
  export TEMU
fi

#if [[ -f "${HOME}/.zsh/$(hostname -s).zshrc" ]] ; then
#  source "${HOME}/.zsh/$(hostname -s).zshrc"
#fi
# Now handled in base zshrc

source "${HOME}/.zsh/zshrc"

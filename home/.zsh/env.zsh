#!/bin/zsh
# ~/.zsh/env.zsh

export HOSTNAME=$(hostname)

# Set pager
export PAGER=vimpager

if [[ ! $TERM =~ screen && $TEMU == terminator ]]; then
  export TERM=xterm-256color
fi
    

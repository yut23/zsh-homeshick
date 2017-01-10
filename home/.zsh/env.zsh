#!/bin/zsh
# ~/.zsh/env.zsh

# Set pager
export PAGER=vimpager

if [[ ! $TERM =~ screen && $TEMU == terminator ]]; then
  export TERM=xterm-256color
fi

# Set editor
export EDITOR=vim
export VISUAL='gvim -f'

# error on invalid globs
setopt NOMATCH


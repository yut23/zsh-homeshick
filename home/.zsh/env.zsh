# ~/.zsh/env.zsh

# Set pager
export PAGER=vimpager

if [[ ! $TERM =~ screen && $TEMU == terminator ]]; then
  export TERM=xterm-256color
fi

# Set editor
export EDITOR=nvim
export VISUAL='nvim-qt --nofork'

# error on invalid globs
setopt NOMATCH

setopt EXTENDEDGLOB

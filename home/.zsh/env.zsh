# ~/.zsh/env.zsh

# Set pager
if (( $+commands[vimpager] )); then
  export PAGER=vimpager
else
  export PAGER=less
fi

# Terminal emulator stuff
if [[ ! $TERM =~ screen && $TEMU == terminator ]]; then
  export TERM=xterm-256color
fi

# Set editor
export EDITOR=nvim
export VISUAL='nvim-qt --nofork'

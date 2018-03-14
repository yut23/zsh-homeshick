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
if [[ -n $DISPLAY ]] && (( $+commands[nvim-qt] )); then
  export VISUAL='nvim-qt --nofork'
fi

export VIRTUAL_ENV_DISABLE_PROMPT='1'

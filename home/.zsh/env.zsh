# ~/.zsh/env.zsh

# Set pager
if (( $+commands[vimpager] )); then
  export PAGER=vimpager
else
  export PAGER=less
fi

# Terminal emulator stuff
if [[ ! ($TERM =~ screen || $TERM =~ tmux) && $TEMU == terminator ]]; then
  export TERM=xterm-256color
fi

# Set editor
export EDITOR=nvim
if [[ -n $DISPLAY ]] && (( $+commands[nvim-qt] )); then
  export VISUAL='nvim-qt --no-ext-tabline --nofork'
fi

export VIRTUAL_ENV_DISABLE_PROMPT='1'

# Add bell to sudo prompt
# this is reverted in my sudo alias, so I should only get a bell when another
# program is calling sudo (like makepkg, or aursync)
export SUDO_PROMPT=$'\a''[sudo] password for %u: '

# set viewer for aurutils (aur-sync)
if (( $+commands[vifm] )); then
  export AUR_PAGER=vifm
else
  export AUR_PAGER=nvim
fi

# always use fancy shell in pipenv
PIPENV_SHELL_FANCY=1

# get rid of intrusive pygame import message
export PYGAME_HIDE_SUPPORT_PROMPT=1

# remove __pycache__ folders (introduced in Python 3.8)
export PYTHONPYCACHEPREFIX="$HOME/.cache/pycache"

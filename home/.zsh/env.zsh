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
if (( $+commands[nvim] )); then
  export EDITOR=nvim
elif (( $+commands[vim] )); then
  export EDITOR=vim
else
  export EDITOR=vi
fi
if [[ -n $DISPLAY ]] && (( $+commands[nvim-qt] )); then
  export VISUAL='nvim-qt --no-ext-tabline --nofork --'
  export SUDO_EDITOR='nvim-qt --no-ext-tabline --nofork'
else
  export VISUAL="$EDITOR"
fi

export VIRTUAL_ENV_DISABLE_PROMPT='1'

# Add bell to sudo prompt
# this is reverted in my sudo alias, so I should only get a bell when another
# program is calling sudo (like makepkg, or aursync)
export SUDO_PROMPT=$'\a''[sudo] password for %u: '

# set viewer for aurutils (aur-sync)
if (( $+commands[aur] )); then
  if (( $+commands[vifm] )); then
    export AUR_PAGER=vifm
  else
    export AUR_PAGER="$EDITOR"
  fi
fi

# always use fancy shell in pipenv
PIPENV_SHELL_FANCY=1

# get rid of intrusive pygame import message
export PYGAME_HIDE_SUPPORT_PROMPT=1

# remove __pycache__ folders (introduced in Python 3.8)
export PYTHONPYCACHEPREFIX="$HOME/.cache/pycache"

# fix man page colors in less
export MANROFFOPT="-c"

# default less(1) options:
# -F: quit if file fits on one screen
# -i: case-insensitive search, unless there are capital letters
# -j5: show 5 lines before the search target
# -R: output color escape sequences raw
export LESS="Fij5R"

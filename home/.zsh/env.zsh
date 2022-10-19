# ~/.zsh/env.zsh

# Set pager
if (( $+commands[vimpager] )); then
  export PAGER=vimpager
else
  export PAGER=less
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
  export VISUAL='nvim-qt --nofork --'
  export SUDO_EDITOR='nvim-qt --nofork'
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

if (( $+commands[pipenv] )); then
  # always use fancy shell in pipenv
  PIPENV_SHELL_FANCY=1
  # look up entire directory tree for a Pipenv file
  export PIPENV_MAX_DEPTH=50
fi

# disable big ascii art banner when running mamba
if (( $+commands[mamba] )); then
  export MAMBA_NO_BANNER=1
fi

# fix man page colors in less
export MANROFFOPT="-c"

# default less(1) options:
# -F: quit if file fits on one screen
# -i: case-insensitive search, unless there are capital letters
# -j5: show 5 lines before the search target
# -R: output color escape sequences raw
# --mouse: turn on mouse scrolling
# --wheel-lines=8: scroll by 8 lines with the mouse wheel (default for terminator)
export LESS="Fij5R"
if (( $+commands[less] )); then
  less_version="${${=$(less --version)}[2]}"
  if (( less_version >= 550 )); then
    LESS="$LESS --mouse --wheel-lines=8"
  fi
  unset less_version
fi


if (( $+commands[rg] )); then
  export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc
  if ! [[ -e "$RIPGREP_CONFIG_PATH" ]]; then
    unset RIPGREP_CONFIG_PATH
  fi
fi

# Forwarded ssh agent: managed by ~/.ssh/rc (in tmux castle)
if [[ -e ~/.ssh/ssh_auth_sock ]]; then
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

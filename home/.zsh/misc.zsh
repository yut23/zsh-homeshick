#!/bin/zsh
# ~/.zsh/misc.zsh

# Set pager
export PAGER=vimpager

# Set colors for ls and completion
eval "$(dircolors -b /etc/DIR_COLORS)"

## Cygwin only: commands that auto-complete with and without .exe or .dll suffixes are annoying.
## thanks Thorsten Kampe & Bart Schaefer
## http://www.zsh.org/mla/users/2009/threads.html#00391
if [[ ${OSTYPE} == 'cygwin' ]] ; then
  setopt EXTENDED_GLOB LOCAL_OPTIONS
  zstyle ':completion:*:-command-:*' ignored-patterns '(#i)*.exe' '(#i)*.dll'
fi

# Use ^z to return to a suspended job
foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey -M emacs '^z' foreground-current-job
bindkey -M viins '^z' foreground-current-job
bindkey -M vicmd '^z' foreground-current-job

# Use a sane cache path
zstyle ":completion::complete:*" cache-path $HOME/.zsh/cache

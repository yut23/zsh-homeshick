#!/bin/zsh
# ~/.zsh/misc.zsh

## Cygwin only: commands that auto-complete with and without .exe or .dll suffixes are annoying.
## thanks Thorsten Kampe & Bart Schaefer
## http://www.zsh.org/mla/users/2009/threads.html#00391
# also fix /c, /d, ... completion
if [[ ${OSTYPE} == 'cygwin' ]] ; then
  setopt EXTENDED_GLOB LOCAL_OPTIONS
  zstyle ':completion:*:-command-:*' ignored-patterns '(#i)*.exe' '(#i)*.dll'
  zstyle ':completion:*' fake-files '/:c' '/:d' '/:h' '/:v' '/:x'
fi

# Use ^z to return to a suspended job
foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey -M emacs '^z' foreground-current-job
bindkey -M viins '^z' foreground-current-job
bindkey -M vicmd '^z' foreground-current-job

# Use a sane cache path
zstyle ":completion::complete:*" cache-path $HOME/.zsh/cache

# for comments on interactive line
setopt INTERACTIVE_COMMENTS

# History
HISTFILE=~/.zsh/history/hist.log
HISTSIZE=1000000
SAVEHIST=1000000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

autoload zmv

# Pacman "command not found"
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# better ls colors
eval `dircolors`
# and use them in completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

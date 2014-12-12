#!/bin/zsh
# ~/.zsh/paths.zsh
# Props to http://github.com/yabawock/dotfiles

# Export existing paths.
typeset -gxU path PATH
typeset -gxU fpath FPATH
typeset -gxU manpath MANPATH
# Create and export new paths.
typeset -gxU infopath INFOPATH
# Tie the new paths.
typeset -gxTU INFOPATH infopath

# Prepend user bin
path[1,0]=$HOME/bin
# Remove any entries that don't actually exist
path=($^path(N-/))

# Include user manpages
manpath+=$HOME/man
manpath=($^manpath(N-/))

# Include user info
infopath+=$HOME/info
infopath=($^infopath(N-/))

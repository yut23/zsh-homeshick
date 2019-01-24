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

# Ruby gems
if which ruby >/dev/null && which gem >/dev/null; then
  path[1,0]="$(ruby -rrubygems -e 'puts Gem.user_dir')/bin"
fi

# Prepend user bin and .local/bin
path[1,0]=($HOME/bin $HOME/.local/bin)
# Remove any entries that don't actually exist
path=($^path(N-/))

# Add custom completions
fpath+=$HOME/.zsh/completions
fpath=($^fpath(N-/))

# Include user manpages
manpath+=$HOME/man
manpath=($^manpath(N-/))

# Include user info
infopath+=$HOME/info
infopath=($^infopath(N-/))

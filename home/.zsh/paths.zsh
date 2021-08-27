# ~/.zsh/paths.zsh
# Props to http://github.com/yabawock/dotfiles

# Export existing paths.
typeset -gxU path PATH
typeset -gxU fpath FPATH
# Create and export new paths.
typeset -gxU infopath INFOPATH
# Tie the new paths.
typeset -gxTU INFOPATH infopath

# Ruby gems
if (( $+commands[ruby] && $+commands[gem] )); then
  path[1,0]="$(ruby -rrubygems -e 'puts Gem.user_dir')/bin"
fi

# LuaRocks rocks
if (( $+commands[luarocks] )); then
  path[1,0]="$(luarocks --local config deploy_bin_dir)"
fi

# dotnet tools
if (( $+commands[dotnet] )); then
  path[1,0]="$HOME/.dotnet/tools"
fi

# Prepend user bin and .local/bin
path[1,0]=("$HOME/bin" "$HOME/.local/bin")
# Prepend architecture-specific bin
path[1,0]=("$HOME/bin/$(uname -m)")
# Remove any entries that don't actually exist
path=($^path(N-/))

# Add custom completions
fpath[1,0]=("$HOME/.zsh/completions")
fpath=($^fpath(N-/))

# Include user info
infopath+=("$HOME/.local/share/info")
infopath=($^infopath(N-/))

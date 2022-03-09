# ~/.zsh/paths.zsh
# Props to http://github.com/yabawock/dotfiles

# Export existing paths.
typeset -gxU path PATH
typeset -gxU fpath FPATH
# Create and export new paths.
typeset -gxU infopath INFOPATH
# Tie the new paths.
typeset -gxTU INFOPATH infopath

() {
  # these are relatively expensive, so cache them
  local cache_file="$cache_dir/paths"
  local -A path_cache
  if [[ -e "$cache_file" ]]; then
    . "$cache_file"
  fi
  local modified=0
  function cache_lookup() {
    local name=$1
    shift
    if ! (( $+path_cache[$name] )); then
      path_cache[$name]="$("$@")"
      modified=1
    fi
    path[1,0]="$path_cache[$name]"
  }
  # Ruby gems
  if (( $+commands[ruby] && $+commands[gem] )); then
    cache_lookup rubygems ruby -rrubygems -e 'puts Gem.user_dir + "/bin"'
  fi

  # LuaRocks rocks
  if (( $+commands[luarocks] )); then
    cache_lookup luarocks luarocks --local config deploy_bin_dir
  fi

  if (( $modified )); then
    typeset path_cache > "$cache_file"
  fi
}

# dotnet tools
if (( $+commands[dotnet] )); then
  path[1,0]="$HOME/.dotnet/tools"
fi

# Prepend user bin and .local/bin
path[1,0]=("$HOME/bin" "$HOME/.local/bin")
# Prepend architecture-specific bin
path[1,0]=("$HOME/bin/$(uname -m)")
if [[ -n $system_name ]]; then
  # Prepend system-specific bin
  path[1,0]=("$HOME/bin/$system_name")
fi
# Remove any entries that don't actually exist
path=($^path(N-/))

# Add custom completions
fpath[1,0]=("$HOME/.zsh/completions")
fpath=($^fpath(N-/))

# Include user info
infopath+=("$HOME/.local/share/info")
infopath=($^infopath(N-/))

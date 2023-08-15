# ~/.zsh/frontier/modules.zsh

() {
# notify if the default modules have changed
local default_modules='craype-x86-trento craype-network-ofi perftools-base xpmem cray-pmi PrgEnv-cray DefApps :'
if [[ $LMOD_SYSTEM_DEFAULT_MODULES != $default_modules ]]; then
  echo 'default modules changed, please regenerate development collection and update ~/.zsh/frontier/modules.zsh'
  # clear the loaded flag so I get nagged inside tmux
  unset _MODULES_LOADED
fi
}
if ! module restore development; then
  if read -q '?Regenerate development collection [yN]? '; then
    echo
    source ~/.zsh/frontier/regen_lmod_collection.zsh
    # this will leave all the modules loaded
  fi
fi

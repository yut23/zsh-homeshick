# ~/.zsh/andes/modules.zsh

() {
# notify if the default modules have changed
local default_modules='DefApps'
if [[ $LMOD_SYSTEM_DEFAULT_MODULES != $default_modules ]]; then
  print -ru2 'default modules changed, please regenerate default collection and update ~/.zsh/andes/modules.zsh'
  print -ru2 -f 'new LMOD_SYSTEM_DEFAULT_MODULES=%s\n' "${(q-)LMOD_SYSTEM_DEFAULT_MODULES}"
  # clear the loaded flag so I get nagged inside tmux
  unset _MODULES_LOADED
fi
}
#if ! module --no_redirect restore; then
#  if read -q '?Regenerate default collection [yN]? '; then
#    print -ru2
#    source ~/.zsh/andes/regen_lmod_collection.zsh
#    # this will leave all the modules loaded
#  fi
#fi

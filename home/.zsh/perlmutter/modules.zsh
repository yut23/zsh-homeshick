# ~/.zsh/perlmutter/modules.zsh

() {
# notify if the default modules have changed
local default_modules='craype-x86-milan:craype-network-ofi:perftools-base:xpmem:PrgEnv-gnu:cpe:gpu:sqs:darshan'
if [[ $LMOD_SYSTEM_DEFAULT_MODULES != $default_modules ]]; then
  print -ru2 'default modules changed, please update ~/.zsh/perlmutter/modules.zsh'
  print -ru2 -f 'new LMOD_SYSTEM_DEFAULT_MODULES=%s\n' "${(q-)LMOD_SYSTEM_DEFAULT_MODULES}"
  # clear the loaded flag so I get nagged inside tmux
  unset _MODULES_LOADED
fi
}
module --no_redirect purge
# From a combination of $LMOD_SYSTEM_DEFAULT_MODULES and the result of
# `ml cudatoolkit`.
module --no_redirect load craype-x86-milan craype-network-ofi perftools-base xpmem PrgEnv-gnu cpe gpu darshan cudatoolkit

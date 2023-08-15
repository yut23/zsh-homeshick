# ~/.zsh/perlmutter/modules.zsh

() {
# notify if the default modules have changed
local default_modules='craype-x86-milan:craype-network-ofi:perftools-base:xpmem:PrgEnv-gnu:cpe:xalt/2.10.2:gpu:'
if [[ $LMOD_SYSTEM_DEFAULT_MODULES != $default_modules ]]; then
  print -ru2 'default modules changed, please update ~/.zsh/perlmutter/modules.zsh'
  # clear the loaded flag so I get nagged inside tmux
  unset _MODULES_LOADED
fi
}
module --no_redirect purge
# From a combination of $LMOD_SYSTEM_DEFAULT_MODULES and the result of
# `ml cudatoolkit`.
module --no_redirect load craype-x86-milan craype-network-ofi perftools-base xpmem PrgEnv-gnu cpe xalt/2.10.2 gpu cudatoolkit

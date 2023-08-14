# ~/.zsh/perlmutter/modules.zsh

# From a combination of $LMOD_SYSTEM_DEFAULT_MODULES and the result of
# `ml cudatoolkit`.
default_modules='craype-x86-milan:craype-network-ofi:perftools-base:xpmem:PrgEnv-gnu:cpe:xalt/2.10.2:gpu:'
if [[ $LMOD_SYSTEM_DEFAULT_MODULES != $default_modules ]]; then
  echo 'default modules changed, please update ~/.zsh/perlmutter/modules.zsh'
fi
unset default_modules
module purge
module load craype-x86-milan craype-network-ofi perftools-base xpmem PrgEnv-gnu cpe xalt/2.10.2 gpu cudatoolkit

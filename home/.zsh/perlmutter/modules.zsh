# ~/.zsh/perlmutter/modules.zsh

# From a combination of $LMOD_SYSTEM_DEFAULT_MODULES, Default, and the result of
# `ml PrgEnv-gnu; ml cpu-cuda; ml cuda`.
module purge
module load craype-x86-rome craype-network-ofi perftools-base xpmem PrgEnv-gnu cpe-cuda cuda cray-pmi cray-pmi-lib xalt darshan python/3.8-anaconda-2021.05

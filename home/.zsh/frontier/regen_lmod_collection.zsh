# ~/.zsh/frontier/regen_lmod_collection.zsh
# this file should be sourced, so the module command is available

module purge
# restore the default system modules, fixing them if necessary
() {
# save the original value so modules.zsh doesn't think the default modules changed
local orig_default_modules=$LMOD_SYSTEM_DEFAULT_MODULES
# workaround for zsh Lmod error: The following module(s) are unknown: ""
# The error occurs in /etc/cray-pe.d/zsh.zshrc.local: if $site_module_list is
# empty, $mlist will have a trailing space. zsh doesn't do word splitting on
# unquoted variables like bash does (unless the SH_WORD_SPLIT option is set),
# so the space is retained in `echo ${mlist}`, leading to a trailing : in
# $LMOD_SYSTEM_DEFAULT_MODULES.
if [[ ${LMOD_SYSTEM_DEFAULT_MODULES: -1} == : ]]; then
  echo 'Working around Lmod error...'
  LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES%:}
else
  echo 'Default modules appear to work properly.'
  echo 'Please remove this workaround from ~/.zsh/frontier/regen_lmod_collection.zsh if there is no error message from Lmod.'
fi
module --no_redirect restore
LMOD_SYSTEM_DEFAULT_MODULES=$orig_default_modules
}
# from https://amrex-astro.github.io/workflow/olcf-compilers.html#frontier
module load PrgEnv-gnu craype-accel-amd-gfx90a cray-mpich rocm amd-mixed
# development tools
module load git htop tmux imagemagick valgrind4hpc

module save development

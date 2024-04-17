# ~/.zsh/frontier/regen_lmod_collection.zsh
# this file should be sourced, so the module command is available

module --no_redirect purge
# restore the default system modules
module --no_redirect restore
# from https://amrex-astro.github.io/workflow/olcf-compilers.html#frontier
module --no_redirect load PrgEnv-gnu craype-accel-amd-gfx90a cray-mpich rocm/5.3.0 amd-mixed/5.3.0
# development tools
module --no_redirect load git htop tmux imagemagick valgrind4hpc

module --no_redirect save development

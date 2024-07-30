# ~/.zsh/frontier/regen_lmod_collection.zsh
# this file should be sourced, so the module command is available

module --no_redirect purge
# restore the default system modules
module --no_redirect restore
# from https://amrex-astro.github.io/workflow/olcf-compilers.html#frontier
module --no_redirect load PrgEnv-gnu
module --no_redirect load cray-mpich/8.1.28
module --no_redirect load craype-accel-amd-gfx90a
module --no_redirect load amd-mixed/6.0.0
module --no_redirect unload darshan-runtime
# development tools
module --no_redirect load git htop tmux imagemagick valgrind4hpc

module --no_redirect save development

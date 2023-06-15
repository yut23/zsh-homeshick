# this file should be sourced, so the module command is available

module purge
module load gcc/10.2.0 spectrum-mpi lsf-tools hsi darshan-runtime xalt cuda/11.3.1 vim git htop tmux imagemagick valgrind
module save development

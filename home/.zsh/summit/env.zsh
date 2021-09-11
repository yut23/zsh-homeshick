# ~/.zsh/summit/env.zsh

export CASTRO_HOME="$HOME/dev/Castro"
export AMREX_HOME="$HOME/dev/amrex"
export MICROPHYSICS_HOME="$HOME/dev/Microphysics"

export PROJID=ast106

export SCRATCH=$(readlink -f "$MEMBERWORK/$PROJID")

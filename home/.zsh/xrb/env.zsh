# ~/.zsh/xrb/env.zsh

export CASTRO_HOME="$HOME/dev/Castro"
export AMREX_HOME="$HOME/dev/amrex"
export MICROPHYSICS_HOME="$HOME/dev/Microphysics"

# use less instead of more
export LMOD_PAGER=less

#export SCRATCH=/scratch

# globus endpoint uuids
if (( $+commands[globus] )); then
  GLOBUS_OLCF_DTN=36d521b3-c182-4071-b7d5-91db5d380d42
  GLOBUS_OLCF_SCRATCH=$GLOBUS_OLCF_DTN:/lustre/orion/ast106/scratch/etjohnson

  GLOBUS_NERSC_DTN=9d6d994a-6d04-11e5-ba46-22000b92c6ec
  GLOBUS_NERSC_SCRATCH=$GLOBUS_NERSC_DTN:/global/pscratch/sd/e/ejohnson

  GLOBUS_XRB_SCRATCH=62967c4a-784c-11ed-92e5-d578f8325bc7:/scratch
fi

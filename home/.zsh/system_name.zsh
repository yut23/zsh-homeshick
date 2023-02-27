# ~/.zsh/system_name.zsh
# Identify the current system (pulled out for external use)
if [[ -n "${NERSC_HOST:+x}" ]]; then
  system_name=$NERSC_HOST
elif [[ -n "${LMOD_SYSTEM_NAME:+x}" ]]; then
  system_name=$LMOD_SYSTEM_NAME
elif [[ "$HOSTNAME" == dtn<->.ccs.ornl.gov ]]; then
  system_name=olcf-dtn
elif [[ "$HOSTNAME" == home<->.ccs.ornl.gov ]]; then
  system_name=olcf-home
elif [[ "$HOSTNAME" == *polaris.alcf.anl.gov ]]; then
  system_name=polaris
else
  system_name=$HOSTNAME
fi
export system_name

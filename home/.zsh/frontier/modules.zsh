# ~/.zsh/frontier/modules.zsh

# update 2025-02-25: something about cray-mpich breaks when loading from a
# collection, so just load all the modules manually
#() {
## notify if the default modules have changed
#local default_modules='craype-x86-trento craype-network-ofi perftools-base xpmem cray-pmi PrgEnv-cray DefApps'
#if [[ $LMOD_SYSTEM_DEFAULT_MODULES != $default_modules ]]; then
#  print -ru2 'default modules changed, please regenerate development collection and update ~/.zsh/frontier/modules.zsh'
#  print -ru2 -f 'new LMOD_SYSTEM_DEFAULT_MODULES=%s\n' "${(q-)LMOD_SYSTEM_DEFAULT_MODULES}"
#  # clear the loaded flag so I get nagged inside tmux
#  unset _MODULES_LOADED
#fi
#}
#if ! module restore development; then
#  if read -q '?Regenerate development collection [yN]? '; then
#    print -ru2
    source ~/.zsh/frontier/regen_lmod_collection.zsh
    # this will leave all the modules loaded
#  fi
#fi

amd_mixed_ver=$(module --redirect --terse list amd-mixed)
amd_mixed_ver=${amd_mixed_ver#amd-mixed/}
if [[ -n $amd_mixed_ver ]] && { printf '%s\n' 6.2 "$amd_mixed_ver" | sort --check=quiet --version-sort }; then
  # workaround needed for amd-mixed/6.2.0 and newer
  # see https://github.com/AMReX-Astro/workflow/pull/42
  export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
fi

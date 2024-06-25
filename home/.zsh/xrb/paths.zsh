# ~/.zsh/xrb/paths.zsh

# this needs to run before env.zsh is loaded, so it can detect mamba
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/eric/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
    if [ -f "/home/eric/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/eric/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/eric/mambaforge/bin:$PATH"
    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

# work around fresh terminals somehow having CONDA_SHLVL set without anything in PATH
if [[ -f "/home/eric/mambaforge/etc/profile.d/conda.sh" ]] && [[ -n ${CONDA_SHLVL+x} ]] && ! (( $path[(I)${CONDA_EXE:h:h}/condabin] )); then
  conda deactivate
  unset CONDA_SHLVL
  # source again to set the path
  . "/home/eric/mambaforge/etc/profile.d/conda.sh"
fi

path+=(/usr/local/cuda/bin)

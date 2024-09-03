# ~/.zsh/nersc/mambaforge_paths.zsh

# need $PROJID
source ~/.zsh/nersc/env.zsh

# this needs to run before env.zsh is loaded, so it can detect mamba
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/global/common/software/$PROJID/env/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
    if [ -f "/global/common/software/$PROJID/env/etc/profile.d/conda.sh" ]; then
        . "/global/common/software/$PROJID/env/etc/profile.d/conda.sh"
    else
        export PATH="/global/common/software/$PROJID/env/bin:$PATH"
    fi
#fi
#unset __conda_setup

if [ -f "/global/common/software/$PROJID/env/etc/profile.d/mamba.sh" ]; then
    . "/global/common/software/$PROJID/env/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

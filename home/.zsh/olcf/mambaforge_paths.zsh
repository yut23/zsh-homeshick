# ~/.zsh/olcf/mambaforge_paths.zsh

# need $PROJID
source ~/.zsh/olcf/env.zsh

# this needs to run before misc.zsh is loaded, so it can find mamba
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$("/ccs/proj/$PROJID/$USER/mambaforge_$(uname -m)/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
    if [ -f "/ccs/proj/$PROJID/$USER/mambaforge_$(uname -m)/etc/profile.d/conda.sh" ]; then
        . "/ccs/proj/$PROJID/$USER/mambaforge_$(uname -m)/etc/profile.d/conda.sh"
    else
        export PATH="/ccs/proj/$PROJID/$USER/mambaforge_$(uname -m)/bin:$PATH"
    fi
    #if [ -f "/sw/summit/python/3.8/anaconda3/2020.07-rhel8/etc/profile.d/conda.sh" ]; then
    #    . "/sw/summit/python/3.8/anaconda3/2020.07-rhel8/etc/profile.d/conda.sh"
    #else
    #    export PATH="/sw/summit/python/3.8/anaconda3/2020.07-rhel8/bin:$PATH"
    #fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

# ~/.zsh/andes/paths.zsh

# this needs to run before misc.zsh is loaded, so it can find mamba
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$("/ccs/proj/$PROJID/$USER/mambaforge_x86_64/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
    if [ -f "/ccs/proj/$PROJID/$USER/mambaforge_x86_64/etc/profile.d/conda.sh" ]; then
        . "/ccs/proj/$PROJID/$USER/mambaforge_x86_64/etc/profile.d/conda.sh"
    else
        export PATH="/ccs/proj/$PROJID/$USER/mambaforge_x86_64/bin:$PATH"
    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

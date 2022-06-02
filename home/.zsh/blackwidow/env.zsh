# ~/.zsh/blackwidow/env.zsh

export CASTRO_HOME="$HOME/dev/Castro"
export AMREX_HOME="$HOME/dev/amrex"
export MICROPHYSICS_HOME="$HOME/dev/Microphysics"

export SCRATCH=/scratch

# this needs to run before plugins.zsh is loaded, so zinit can detect conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/eric/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
    if [ -f "/home/eric/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/eric/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/eric/miniconda3/bin:$PATH"
    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

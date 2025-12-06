# ~/.zsh/mandelbrot/paths.zsh

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

#if [ -f "/home/eric/mambaforge/etc/profile.d/mamba.sh" ]; then
#    . "/home/eric/mambaforge/etc/profile.d/mamba.sh"
#fi
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/eric/mambaforge/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/eric/mambaforge';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

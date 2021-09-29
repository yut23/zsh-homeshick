# ~/.zsh/andes/misc.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/sw/andes/python/3.7/anaconda-base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/sw/andes/python/3.7/anaconda-base/etc/profile.d/conda.sh" ]; then
        . "/sw/andes/python/3.7/anaconda-base/etc/profile.d/conda.sh"
    else
        export PATH="/sw/andes/python/3.7/anaconda-base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate andes

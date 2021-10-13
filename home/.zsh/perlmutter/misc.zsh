# ~/.zsh/perlmutter/misc.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/global/common/software/nersc/shasta2105/python/3.9-anaconda-2021.05/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/global/common/software/nersc/shasta2105/python/3.9-anaconda-2021.05/etc/profile.d/conda.sh" ]; then
        . "/global/common/software/nersc/shasta2105/python/3.9-anaconda-2021.05/etc/profile.d/conda.sh"
    else
        export PATH="/global/common/software/nersc/shasta2105/python/3.9-anaconda-2021.05/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

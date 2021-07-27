# ~/.zsh/cori/misc.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/common/software/python/3.8-anaconda-2020.11/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/common/software/python/3.8-anaconda-2020.11/etc/profile.d/conda.sh" ]; then
        . "/usr/common/software/python/3.8-anaconda-2020.11/etc/profile.d/conda.sh"
    else
        export PATH="/usr/common/software/python/3.8-anaconda-2020.11/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

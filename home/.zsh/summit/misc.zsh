# ~/.zsh/summit/misc.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/sw/summit/python/3.7/anaconda3/5.3.0/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/sw/summit/python/3.7/anaconda3/5.3.0/etc/profile.d/conda.sh" ]; then
        . "/sw/summit/python/3.7/anaconda3/5.3.0/etc/profile.d/conda.sh"
    else
        export PATH="/sw/summit/python/3.7/anaconda3/5.3.0/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate myenv

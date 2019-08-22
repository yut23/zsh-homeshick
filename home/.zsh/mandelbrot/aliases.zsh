# ~/.zsh/mandelbrot/aliases.zsh

alias vim='echo Use nvim! #'
alias view='echo Use nvim! #'
alias vimdiff='echo Use nvim! #'

alias gvim='echo Use nvim-qt! #'
alias gview='echo Use nvim-qt! #'
alias gvimdiff='echo Use nvim-qt! #'

alias gnvim='NVIM_GUI=1 nvim-qt --no-ext-tabline'
alias nview='nvim -R'
alias nvimdiff='nvim -d'
alias gnview='gnvim -- -R'
alias gnvimdiff='gnvim -- -d'

alias ccm32='sudo ccm32'
alias ccm64='sudo ccm64'

alias clear="echo -ne '\ec'"

alias mux=tmuxinator

alias aursearch=$HOME/bin/aursearch.sh

alias ksc=kaitai-struct-compiler

alias edit-parallel-summary='source ~/school/parallel/summaries/edit_parallel_summary.zsh'

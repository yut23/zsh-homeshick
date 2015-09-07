# ~/.zsh/antigen.zsh

source "$HOME/zsh/antigen/antigen.zsh"

# Load oh-my-zsh inside antigen
antigen use oh-my-zsh

# Bundles from oh-my-zsh repo
antigen bundle git
antigen bundle history-substring-search

antigen theme "$HOME/.zsh/themes" yut23

antigen apply
unset GREP_OPTIONS


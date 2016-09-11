# ~/.zsh/antigen.zsh

source "$HOME/.antigen/antigen.zsh"

# Load oh-my-zsh inside antigen
antigen use oh-my-zsh

# Bundles from oh-my-zsh repo
antigen bundle git

antigen bundle zsh-users/zsh-history-substring-search
# runs ls and git status after cd
antigen bundle dbkaplun/smart-cd
# don't automatically run multiline pastes
antigen bundle oz/safe-paste


antigen theme "$HOME/.zsh/themes" yut23

antigen apply
unset GREP_OPTIONS


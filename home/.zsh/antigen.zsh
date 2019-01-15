# ~/.zsh/antigen.zsh

# use unified zcompdump file
export ANTIGEN_COMPDUMP="$HOME/.zsh/cache/zcompdump"


source "$HOME/.antigen/antigen.zsh"

antigen bundle zsh-users/zsh-history-substring-search
# don't automatically run multiline pastes
antigen bundle oz/safe-paste

# node version manager
antigen bundle lukechilds/zsh-nvm
# and completion
antigen bundle lukechilds/zsh-better-npm-completion

antigen bundle fnoris/keybase-zsh-completion

# load local plugins:
# * smart-cd: runs ls and git status after cd
antigen bundle "$HOME/.zsh/plugins"


# set theme stuff up now that we don't use OMZ
fpath=($HOME/.zsh/themes $fpath)
autoload -U promptinit && promptinit
autoload -U colors && colors
prompt yut23
prompt yut23

antigen apply
unset GREP_OPTIONS


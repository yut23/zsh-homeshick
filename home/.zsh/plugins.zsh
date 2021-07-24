# ~/.zsh/plugins.zsh

# don't automatically run multiline pastes
#zinit ice wait lucid
zinit load oz/safe-paste

zinit load zsh-users/zsh-history-substring-search
zinit ice wait"0" lucid
zinit load zdharma/history-search-multi-word

# node version manager
zinit ice wait"1" lucid
zinit load lukechilds/zsh-nvm
# and completion
zinit ice wait"1" lucid has'npm'
zinit load lukechilds/zsh-better-npm-completion

zinit ice wait"1" lucid has'keybase'
zinit load fnoris/keybase-zsh-completion

zinit ice has'lua'
zinit light skywind3000/z.lua

# automatically run .autoenv.zsh scripts on cd
AUTOENV_FILE_LEAVE=.autoenv.zsh
zinit light Tarrasch/zsh-autoenv

# load local plugins:
# * smart-cd: runs ls and git status after cd
zinit light "$HOME/.zsh/plugins"

# homeshick completion
zinit ice as'completion'
zinit snippet "$HOME/.homesick/repos/homeshick/completions/_homeshick"

# load ssh-ident
zinit ice as'program' pick'bin/s*'
zinit light yut23/ssh-ident

# set theme stuff up now that we don't use OMZ
fpath=($HOME/.zsh/themes $fpath)
autoload -U promptinit && promptinit
autoload -U colors && colors
prompt yut23
prompt yut23

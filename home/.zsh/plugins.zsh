# ~/.zsh/plugins.zsh

# needed for safe-paste to add its binding to the right keymap, on zsh < 5.1
bindkey -v
# don't automatically run multiline pastes
#zinit ice wait lucid
zinit snippet OMZ::plugins/safe-paste

zinit load zsh-users/zsh-history-substring-search
zinit ice wait'0' lucid
zinit load zdharma/history-search-multi-word

# node version manager
zinit ice wait'1' lucid has'npm'
zinit load lukechilds/zsh-nvm
# and completion
zinit ice wait'1' lucid has'npm'
zinit load lukechilds/zsh-better-npm-completion

zinit ice wait'1' lucid has'keybase'
zinit load fnoris/keybase-zsh-completion

zinit ice wait'1' lucid has'conda'
zinit load esc/conda-zsh-completion

# treat hyphen as a normal character, rather than lua's *?
export _ZL_HYPHEN=1
zinit ice has'lua'
zinit light skywind3000/z.lua

# automatically run .autoenv.zsh scripts on cd
AUTOENV_FILE_LEAVE=.autoenv.zsh
zinit ice nocompletions
zinit light Tarrasch/zsh-autoenv

# load local plugins:
# * smart-cd: runs ls and git status after cd
zinit light "$HOME/.zsh/plugins"

# homeshick completion
if [[ ! -f $ZINIT[COMPLETIONS_DIR]/_homeshick ]]; then
  zinit creinstall %HOME/.homesick/repos/homeshick/completions
fi

# load ssh-ident
zinit ice as'program' pick'bin/s*' has'python'
zinit light yut23/ssh-ident

# this must load after the last completion-related plugin
zinit ice wait'1' lucid as'null' id-as'zsh-compinit-null' nocd \
  atload'zicompinit; zicdreplay'
zinit light zdharma/null

# set theme stuff up now that we don't use OMZ
fpath=($HOME/.zsh/themes $fpath)
autoload -U promptinit && promptinit
autoload -U colors && colors
# IDK why this needs to be run twice, but it does
prompt yut23
prompt yut23

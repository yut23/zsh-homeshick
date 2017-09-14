# ~/.zsh/history.zsh

HISTFILE=~/.zsh/history/hist.log
HISTSIZE=1000000
SAVEHIST=1000000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# prevent history from becoming too cluttered
HISTORY_IGNORE='(l|l *|ls|ls *|la|la *|ll|ll *|cd|cd ..|cd -*|g st|g ls)'

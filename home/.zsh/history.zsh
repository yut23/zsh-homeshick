# ~/.zsh/history.zsh

HISTFILE=~/.zsh/history/hist.log
HISTSIZE=1000000
SAVEHIST=1000000
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt no_hist_ignore_all_dups
setopt extended_history
setopt share_history

# prevent history from becoming too cluttered
HISTORY_IGNORE='(l|l *|ls|ls *|la|la *|ll|ll *|cd|cd ..|cd -*|g st|g ls)'

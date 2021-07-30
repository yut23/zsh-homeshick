# ~/.zsh/history.zsh
autoload -Uz is-at-least

HISTFILE=~/.zsh/history/hist.log
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt no_hist_ignore_all_dups
setopt extended_history
setopt share_history
# this is mutually exclusive with share_history
setopt no_inc_append_history
is-at-least 5.0.6 && setopt no_inc_append_history_time
setopt hist_fcntl_lock

# prevent history from becoming too cluttered
HISTORY_IGNORE='(l|l *|ls|ls *|la|la *|ll|ll *|cd|cd ..|cd -*|g st|g ls)'

# ensure history directory exists
if [[ ! -d ${HISTFILE%/*} ]]; then
  mkdir -p ${HISTFILE%/*}
fi

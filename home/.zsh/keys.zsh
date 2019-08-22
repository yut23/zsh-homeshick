# ~/.zsh/keys.zsh

# vi mode
bindkey -v

noop () { true; }
zle -N noop

# Fix keybindings
bindkey 'OH' beginning-of-line
bindkey 'OF' end-of-line
bindkey '[3~' delete-char
bindkey '' backward-delete-char
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '[H' beginning-of-line
bindkey '[F' end-of-line

# unbind insert
bindkey -r "[2~"

# linux console
bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line

bindkey -M menuselect '[Z' reverse-menu-complete
bindkey 'h' run-help

# Switch from <Esc> to jj
# This also fixes all of the random switches into vi-cmd-mode
bindkey -M viins '' noop
bindkey -M viins 'jj' vi-cmd-mode

# Shift-Return to insert newline
bindkey '^J' self-insert

zmodload zsh/terminfo
# bind UP and DOWN arrow keys
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '[A' history-substring-search-up
bindkey '[B' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# bind ctrl-backspace to delete previous word
bindkey '' backward-kill-word
# bind ctrl-delete to delete next word
bindkey '[3;5~' kill-word

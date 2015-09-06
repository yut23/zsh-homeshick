#!/bin/zsh
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

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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

# Switch from <Esc> to jj
# This also fixes all of the random switches into vi-cmd-mode
bindkey -M viins '' noop
bindkey -M viins 'jj' vi-cmd-mode

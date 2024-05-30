# ~/.zsh/keys.zsh

# vi mode
bindkey -v

noop () { true; }
zle -N noop

zmodload zsh/terminfo
# Fix keybindings
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# unbind insert
bindkey -r "^[[2~"

# linux console
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey '^[h' run-help

# Switch from <Esc> to jj
# This also fixes all of the random switches into vi-cmd-mode
bindkey -M viins '^[' noop
bindkey -M viins 'jj' vi-cmd-mode
# Decrease the time to wait for the rest of a prefix from 0.4s to 0.2s
KEYTIMEOUT=20

if [[ $HOST != ZB<->-host ]]; then  # breaks zsh-bench
  # Shift-Return to insert newline
  bindkey '^J' self-insert
fi

# bind up and down arrow keys to search through history
if zle -l history-substring-search-up history-substring-search-down; then
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  # bind k and j for VI mode
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
else
  bindkey "$terminfo[kcuu1]" up-line-or-search
  bindkey "$terminfo[kcud1]" down-line-or-search
  bindkey '^[[A' up-line-or-search
  bindkey '^[[B' down-line-or-search
fi

# bind ctrl-backspace to delete previous word
bindkey '^H' backward-kill-word
# bind ctrl-delete to delete next word
bindkey '^[[3;5~' kill-word
# bind alt-delete as well, for symmetry with alt-backspace
bindkey '^[[3;3~' kill-word

# bind ctrl-backspace in neovim terminal
bindkey '^[[127;5u' backward-kill-word
# workaround for hsmw, waiting on https://github.com/zdharma/history-search-multi-word/issues/16
bindkey -M emacs -s '^[[127;5u' '^W'

# allow digit arguments before commands/keybindings in vi mode (same as emacs)
for i in {0..9}; do
  bindkey "^[$i" digit-argument
done
bindkey "^[-" neg-argument

# from OMZ fancy-ctrl-z plugin (https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/fancy-ctrl-z)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 && $CONTEXT == start ]]; then
    zle grml-zsh-fg
  else
    zle push-line-or-edit
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

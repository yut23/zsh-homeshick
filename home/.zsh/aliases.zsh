# ~/.zsh/aliases.zsh

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc
#alias less='less -r'                          # raw control characters
#alias whence='type -a'                        # where, of a sort
# show differences in colour, exclude vcs directories
alias grep='grep --color --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn'
alias egrep='grep --color=auto -E'            # show differences in colour
alias fgrep='grep --color=auto -F'            # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --group-directories-first --color=auto'
alias l='ls -la'
alias la='ls -lA'
alias ll='ls -l'

if (( $+commands[tree] )); then
  alias tree='tree --dirsfirst -F'
fi

#alias echo='echo -e'
#alias cd..='cd ..'
#alias ..='cd ..'

#alias diff='colordiff'
compdef colordiff=diff
alias locater='noglob locate --regex'

alias history='fc -il'
# hag searches history and displays extra metadata, hagc just prints commands
() {
  local searcher cmd
  if (( $+commands[rg] )); then
    searcher=rg
    cmd=rg
  elif (( $+commands[ag] )); then
    searcher=ag
    cmd=ag
  else
    searcher=grep
    cmd="grep -E"
  fi
  alias hag="fc -il 1 | grep -vE '  hagc? ' | $cmd"
  alias hagc="fc -ln 1 | grep -vE '^hagc? ' | $cmd"
  alias psa='ps ax | grep -vE "\b'"$searcher"'\b" | '"$cmd"
}

alias free='free -m'
if (( $+commands[axel] )); then
  alias axel='axel -a'
fi

alias hs='homeshick'

# make the directory stack a little bit easier to use
alias dirs='dirs -pv'
alias d='dirs -v | head -10'

# Help
autoload -U run-help
autoload run-help-git
# I already know how to use sudo!
autoload run-help-sudo

alias run-help > /dev/null && unalias run-help
alias help=run-help

# expand aliases under sudo, and disable bell when calling directly
alias sudo='sudo -p"[sudo] password for %u: " '
alias sudoedit='sudoedit -p"[sudo] password for %u: "'

# use old behavior, with multiple connections
if (( $+commands[aria2c] )); then
  alias aria2c='aria2c --max-connection-per-server=4 --min-split-size=1M'
fi

# hide annoying configuration banner
if (( $+commands[ffmpeg] )); then
  alias ffmpeg='ffmpeg -hide_banner'
  alias ffplay='ffplay -hide_banner'
  alias ffprobe='ffprobe -hide_banner'
  alias ffserver='ffserver -hide_banner'
fi

# shorthand for systemd commands
alias sctl='systemctl'
alias jctl='journalctl'
alias sctlu='systemctl --user'
alias jctlu='journalctl --user'

# systemd-cgtop doesn't clear the screen if the terminal is dumb (see cgtop.c#display())
alias cgtop='TERM=dumb systemd-cgtop --cpu=time /user.slice/user-$UID.slice -n 1'
alias cgls='systemd-cgls --no-pager /user.slice/user-$UID.slice'

# various neovim aliases
if (( $+commands[nvim] )); then
  alias nview='nvim -R'
  alias nvimdiff='nvim -d'
fi
if (( $+commands[nvim-qt] )); then
  if [[ $system_name == xrb ]]; then
    # run nvim-qt in a new cgroup, so linters don't take down the terminal
    alias gnvim='systemd-run --quiet --user --scope --setenv=NVIM_GUI=1 nvim-qt'
  else
    alias gnvim='NVIM_GUI=1 nvim-qt'
  fi
  alias gnview='gnvim -- -R'
  alias gnvimdiff='gnvim -- -d'
fi

# git shorthand
alias g='git'
# open fugitive status window directly
alias fugitive="$EDITOR"' +Ge\ :'

# use stars in find predicates
alias find='noglob find'

# calculate the sum of numbers on stdin
alias total='python -c "import sys; print((lambda x: int(x) if x%1 == 0 else x)(sum(map(float, sys.stdin))))"'

# don't display icons in xprop
if (( $+commands[xprop] )); then
  alias xprop='xprop -len 1000'
fi

# like l, but for cls
alias cl='cls -lA'

if (( $+commands[scrot] )); then
  alias scrot='scrot --silent'
fi

if (( $+commands[tmuxinator] )); then
  alias mux=tmuxinator
fi

alias urldecode='python -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()))"'
alias urlencode='python -c "import sys; from urllib.parse import quote; print(quote(sys.stdin.read()))"'

if [[ -d ~/.tmux/clipboard ]]; then
  alias purgeclip=~/.tmux/clipboard/purge.sh
  alias putclip=~/.tmux/clipboard/pushclip.sh
  alias getclip=~/.tmux/clipboard/getcopybuffer.sh
fi

if (( $+commands[etckeeper] )); then
  alias etckeeper='sudo etckeeper'
  alias ek=etckeeper
  alias ekg='etckeeper vcs'
fi

# fix complaint about no LINES variable in environment
if (( $+commands[uniname] )) && (( $+LINES )); then
  alias uniname='LINES=$LINES uniname'
fi

# convert null-terminated lines to standard NL-terminated lines
alias z2nl='tr \\000 \\n'
# and vice versa
alias nl2z='tr \\n \\000'

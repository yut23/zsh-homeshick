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

#alias echo='echo -e'
#alias cd..='cd ..'
#alias ..='cd ..'

#alias diff='colordiff'
compdef colordiff=diff
alias locater='noglob locate --regex'

alias history='fc -il'
# hag searches history and displays extra metadata, hagc just prints commands
if (( $+commands[ag] )); then
  alias hag="fc -il 1 | grep -vE '  hagc? ' | ag"
  alias hagc="fc -ln 1 | grep -vE '^hagc? ' | ag"
  alias psa='ps ax | grep -vE "\bag\b" | ag'
else
  alias hag="fc -il 1 | grep -vE '  hagc? ' | grep"
  alias hagc="fc -ln 1 | grep -vE '^hagc? ' | grep"
  alias psa='ps ax | grep -vE "\bgrep\b" | grep --color=always'
fi

alias free='free -m'
alias axel='axel -a'

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
alias aria2c='aria2c --max-connection-per-server=4 --min-split-size=1M'

# hide annoying configuration banner
alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffplay -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffserver='ffserver -hide_banner'

# shorthand for systemd commands
alias sctl='systemctl'
alias jctl='journalctl'
alias sctlu='systemctl --user'
alias jctlu='journalctl --user'

# git shorthand
alias g='git'

# use stars in find predicates
alias find='noglob find'

# calculate the sum of numbers on stdin
alias total='python -c "import sys; print(sum(map(int, sys.stdin)))"'

# don't display icons in xprop
if (( $+commands[xprop] )); then
  alias xprop='xprop -len 1000'
fi

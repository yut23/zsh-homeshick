#!/bin/zsh
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
#alias dir='ls --color=auto --format=vertical'
#alias vdir='ls --color=auto --format=long'
#alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias lla='ls -lA'                            #
#alias l='ls -CF'                              #

#alias echo='echo -e'
#alias cd..='cd ..'
#alias ..='cd ..'

alias gzip='pigz'
#alias diff='colordiff'
alias locater='locate --regextype=posix-extended --regex'

alias hag='history | grep -v hag | ag'
alias vim='vim -o'

alias free='free -m'
alias psg='ps ax | grep -v grep | grep --color=always'
alias psa='ps ax | grep -vE "\bag\b" | ag'
alias axel='axel -a'

alias hs='homeshick'

# make the directory stack a little bit easier to use
alias dirs='dirs -pv'

# Help
autoload -U run-help
autoload run-help-git
# I already know how to use sudo!
autoload run-help-sudo

alias run-help > /dev/null && unalias run-help
alias help=run-help

# use GraphicksMagic
unalias gm

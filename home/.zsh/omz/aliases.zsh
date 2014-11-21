#!/bin/zsh
# ~/.zsh/omz/aliases.zsh

# Interactive operation...
# alias rm='rm -i'
alias rm='/usr/bin/trash-put'
# alias cp='cp -i'
alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
#alias less='less -r'                          # raw control characters
#alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='grep --color=auto -E'            # show differences in colour
alias fgrep='grep --color=auto -F'            # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hFX --group-directories-first --color=auto'
#alias dir='ls --color=auto --format=vertical'
#alias vdir='ls --color=auto --format=long'
#alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias lla='ls -lA'                            #
#alias l='ls -CF'                              #

#alias echo='echo -e'
#alias open='cygstart'
#alias cd..='cd ..'
#alias ..='cd ..'

alias gzip='pigz'
#alias diff='colordiff'
alias locater='locate --regextype=posix-extended --regex'

alias hag='history | grep -v hag | ag'
alias vim='vim -o'

alias free='free -m'
alias psg='ps ax | grep -v grep | grep --color=always'
alias psa='ps ax | grep -v ag | ag'
alias axel='axel -a'

#alias hs='homeshick'
#complete -o default -F _homeshick_complete hs

#alias g='git'
#complete -o default -o nospace -F _git g

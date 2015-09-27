#!/bin/zsh
# ~/.zsh/Eric-Laptop/aliases.zsh

alias rm='/usr/bin/trash-put'
alias trash-list='trash-list | sort'
alias open='cygstart'
alias csc='/c/Windows/Microsoft.NET/Framework64/v4.0.30319/csc.exe'

alias cyg='sudo apt-cyg -i -M "http://sourceware.mirrors.tds.net/pub/sourceware.org/cygwin"'
alias cygp='sudo apt-cyg -i -M "http://sourceware.mirrors.tds.net/pub/sourceware.org/cygwinports"'

alias memg++='i686-w64-mingw32-g++.exe -static-libgcc -static-libstdc++ -ggdb'
alias drmemory='drmemory -batch' # don't open notepad

# ~/.zsh/misc.zsh

cachedir="$HOME/.zsh/cache"

# === Shell Options ===
# error on invalid globs
setopt nomatch
setopt extendedglob
# comments on interactive line
setopt interactive_comments


## Cygwin only: commands that auto-complete with and without .exe or .dll suffixes are annoying.
## thanks Thorsten Kampe & Bart Schaefer
## http://www.zsh.org/mla/users/2009/threads.html#00391
# also fix /c, /d, ... completion
if [[ ${OSTYPE} == 'cygwin' ]] ; then
  setopt EXTENDED_GLOB LOCAL_OPTIONS
  zstyle ':completion:*:-command-:*' ignored-patterns '(#i)*.exe' '(#i)*.dll'
  zstyle ':completion:*' fake-files '/:c' '/:d' '/:h' '/:v' '/:x'
fi

# Use ^z to return to a suspended job
foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey -M emacs '^z' foreground-current-job
bindkey -M viins '^z' foreground-current-job
bindkey -M vicmd '^z' foreground-current-job


# handy for moving/copying groups of files
autoload zmv

# better ls colors
eval `dircolors`
# and use them in completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Pacman "command not found"
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi


# GRML settings
export COMMAND_NOT_FOUND=0     # disable command not found hook
export GRML_COMP_CACHING='no'  # handled by antigen
export GRML_NO_APT_ALIASES=1   # disable apt-* aliases
export GRML_NO_SMALL_ALIASES=1 # disable extraneous aliases
export REPORTTIME=5  # show time info for commands that run longer than 5 seconds
export COMPDUMPFILE="$HOME/.zsh/cache/zcompdump"  # use unified compdump file

# disable persistent dirstack
zstyle ':grml:chpwd:dirstack' enable false


# === Completion ===

setopt auto_menu
setopt complete_in_word
zstyle ':completion:*:*:*:*:*' menu select

# Use caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$cachedir"

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show

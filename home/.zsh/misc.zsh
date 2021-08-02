# ~/.zsh/misc.zsh

cachedir="$HOME/.zsh/cache"

# === Shell Options ===
# error on invalid globs
setopt nomatch
setopt extendedglob
# comments on interactive line
setopt interactive_comments
# make cd -<number> match what dirs -v (aka d) outputs
setopt pushd_minus

# Use slash as word separator
WORDCHARS="${WORDCHARS:s@/@}"

# Don't notify about other users logging in
watch=($USER root)


## Cygwin only: commands that auto-complete with and without .exe or .dll suffixes are annoying.
## thanks Thorsten Kampe & Bart Schaefer
## http://www.zsh.org/mla/users/2009/threads.html#00391
# also fix /c, /d, ... completion
if [[ ${OSTYPE} == 'cygwin' ]] ; then
  setopt EXTENDED_GLOB LOCAL_OPTIONS
  zstyle ':completion:*:-command-:*' ignored-patterns '(#i)*.exe' '(#i)*.dll'
  zstyle ':completion:*' fake-files '/:c' '/:d' '/:h' '/:v' '/:x'
fi

# from OMZ fancy-ctrl-z plugin (https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/fancy-ctrl-z)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-line-or-edit
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


# handy for moving/copying groups of files
autoload zmv
# make zmv easier to use
alias zmv='noglob zmv -W'
alias zcp='noglob zmv -CW'

# better ls colors
eval `dircolors -b "$HOME/.zsh/.dircolors"`
# and use them in completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Pacman "command not found"
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi


# === Named directories ===

if [[ -n ${CASTRO_HOME+x} ]]; then
  hash -d castro=$CASTRO_HOME
  hash -d fw=$CASTRO_HOME/Exec/science/flame_wave
fi
if [[ -n ${SCRATCH+x} ]]; then
  hash -d scratch=$SCRATCH
fi


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
        usbmux uucp vcsa wwwrun xfs '_*' \
        chrony 'cray*' cvmfs dockremap fetchmail ftpsecure gitlab-runner \
        gpfsadmin logstash mongodb munge myproxyoauth nersciris nginx openslp \
        oprofile prometheus rabbitmq redis scalepm sdnapi shifter srvGeoClue \
        stunnel 'systemd-*' tss vnc vscan
# ... unless we really want to.
zstyle '*' single-ignored show

# Always show menu if there are multiple matches, even if a complete match is entered
zstyle ':completion:*' accept-exact false

# ~/.zsh/Eric-Laptop.zshrc

# Set the timezone correctly
export TZ=EST5EDT

export EDITOR=vim

tempvar=$(echo /cygdrive/d/Java/64/eclipse/plugins/org.apache.ant_*/bin)
export PATH=$PATH:$tempvar
unset tempvar

export UH='/cygdrive/c/Users/Eric'

# Attach to Cygwin/X server if available
if [ ! -e "/tmp/.X11-unix/X0" ]; then
	/usr/bin/startxwin.exe -multiwindow >/dev/null 2>&1
fi
export DISPLAY=:0.0

# ssh-pageant
#eval $(/usr/bin/ssh-pageant -ra /tmp/.ssh-pageant) > /dev/null
#if [ -z "$SSH_AUTH_SOCK" -a -x /usr/bin/ssh-pageant ]; then
#	eval $(/usr/bin/ssh-pageant -q)
#	trap logout HUP
#fi

if [[ -z "$SSH_AUTH_SOCK" && -x /usr/bin/keychain ]]; then
  keychain -Q --inherit any
  source "$HOME/.keychain/$(hostname)-sh"
  trap "echo HUP Trapped >>/tmp/trap.txt" HUP
fi
# vim: filetype=zsh

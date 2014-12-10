#!/bin/zsh
# ~/.zsh/Eric-Laptop/env.zsh

export TZ=EST5EDT

export UH='/cygdrive/c/Users/Eric'

# Attach to Cygwin/X server if available
if [ ! -e "/tmp/.X11-unix/X0" ]; then
	/usr/bin/xlaunch.exe -run /etc/X11/multiwindow.xlaunch >/dev/null 2>&1
fi
export DISPLAY=:0.0

/usr/bin/keychain -q -Q
source "$HOME/.keychain/$(hostname)-sh"

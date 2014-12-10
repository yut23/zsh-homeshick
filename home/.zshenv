# ~/.zshenv

source "$HOME/.zsh/paths.zsh"

# Disable coredumps
ulimit -c 0

# Set editor
export EDITOR=vim

# Detect terminal emulator
if [[ -z "${TEMU}" ]]; then
  export TEMU=$(basename $(ps -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))
fi

#if [[ -f "${HOME}/.zsh/$(hostname -s).zshrc" ]] ; then
#  source "${HOME}/.zsh/$(hostname -s).zshrc"
#fi
# Now handled in base zshrc

source "${HOME}/.zsh/zshrc"


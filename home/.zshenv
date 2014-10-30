# ~/.zshenv

# Set PATH so it includes user's private bin if it exists
if [[ -d "${HOME}/bin" ]] ; then
	PATH="${HOME}/bin:${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
if [[ -d "${HOME}/man" ]] ; then
	MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [[ -d "${HOME}/info" ]] ; then
	INFOPATH="${HOME}/info:${INFOPATH}"
fi

# Set editor
export EDITOR=vim

if [[ -f "${HOME}/.zsh/$(hostname -s).zshrc" ]] ; then
	source "${HOME}/.zsh/$(hostname -s).zshrc"
fi

#if [[ -f "${HOME}/.zsh/zshrc" ]] ; then
	source "${HOME}/.zsh/zshrc"
#fi


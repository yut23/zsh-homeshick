# ~/.zsh/summit/aliases.zsh

# zsh's builtin which is much better
if [[ $(whence -w which) == 'which: alias' ]]; then
  unalias which
fi

alias hsi='ptypipe "cdls /hpss/prod/$PROJID/users/$USER" hsi'
alias bstat='jobstat -u $USER'

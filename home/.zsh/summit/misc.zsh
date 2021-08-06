# ~/.zsh/summit/misc.zsh

# zsh's builtin which is much better
if [[ $(whence -w which) == 'which: alias' ]]; then
  unalias which
fi

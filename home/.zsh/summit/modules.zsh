# ~/.zsh/summit/modules.zsh

if ! module restore development; then
  if read -q '?Regenerate development collection [yN]? '
    source ~/.zsh/summit/regen_lmod_collection.zsh
    # this will leave all the modules loaded
  fi
fi

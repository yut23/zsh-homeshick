# Modified to use pure zsh functions instead of grep
git_prompt_status() {
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if [[ $INDEX =~ '('$'\n''|^)\?\? ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)[AM]  ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)[ A]M ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)R  ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)[ A]D ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif [[ $INDEX =~ '('$'\n''|^)D  ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)UU ' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)## .*ahead' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)## .*behind' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if [[ $INDEX =~ '('$'\n''|^)## .*diverged' ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  echo "$STATUS"
}

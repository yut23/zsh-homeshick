# ~/.zsh/summit/modules.zsh

if [[ -z "${MODULES_LOADED+x}" ]]; then
  # quiet flag for cuda/11.2.0
  module -q restore development
  export MODULES_LOADED=1
fi

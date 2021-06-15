#!/usr/bin/env zsh

: ${SMART_CD_LS:=true} ${SMART_CD_GIT_STATUS:=true} ${SMART_CD_ONLY_IF_FITS:=true}

_smart_cd_lastgitdir=''
_smart_cd_chpwd_handler () {
  emulate -L zsh

  if [[ $SMART_CD_LS == true ]]; then
    if [[ ($SMART_CD_ONLY_IF_FITS != true) ||
          (($SMART_CD_ONLY_IF_FITS == true) &&
          ($(ls -1 | wc -l) -lt $(tput lines))) ]]; then
      ls -hF --group-directories-first --color=auto
    fi
  fi

  if [[ $SMART_CD_GIT_STATUS == true ]]; then
    local gitdir="$(git rev-parse --git-dir 2>/dev/null)"
    if [[ -n "$gitdir" ]]; then
      gitdir="$gitdir:A" # absolute path of $gitdir
      [[ "$gitdir" != "$_smart_cd_lastgitdir" ]] && (echo; git status)
      _smart_cd_lastgitdir="$gitdir"
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _smart_cd_chpwd_handler
#_smart_cd_chpwd_handler

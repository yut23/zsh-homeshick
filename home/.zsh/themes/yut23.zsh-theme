# ZSH Theme - Preview: http://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

local return_code="%(?..%{$fg_bold[red]%}%?%{$reset_color%})"

# vim mode indicator
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
  [[ ($TERM =~ "xterm.*" || $TERM =~ "screen.*") && $KEYMAP == 'vicmd' ]] && echo -n '[1 q' || echo -n '[5 q'
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
  [[ $TERM =~ "xterm.*" || $TERM =~ "screen.*" ]] && echo -n '[5 q'
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  zle && zle reset-prompt
  return $(( 128 + $1 ))
}

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  if [[ -n $GIT_STATUS ]]; then
    if [[ $GIT_STATUS =~ [%+*~\!?] ]]; then
      echo "%{$terminfo[bold]$fg[red]%}(${ref#refs/heads/} $GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
    else
      echo "%{$terminfo[bold]$fg[yellow]%}(${ref#refs/heads/} $GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
  else
    echo "%{$terminfo[bold]$fg[green]%}(${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

function get_prompt_symbol() {
  local groups
  groups=($(id -G))
  # magic subscript globbing ahead
  (( ${+groups[(r)0]} )) && echo '#' || echo '$'
}

# different color for ssh session
#if [[ "z${SSH_CLIENT}" != "z" && ! "${SSH_CLIENT}" =~ 127\.0\.0\.1 ]]; then
local user='%{$fg[green]%}%n%{$reset_color%}'
if [[ "z${SSH_CLIENT}" != "z" ]]; then
  local host='%{$fg[cyan]%}@%m%{$reset_color%}'
else
  local host='%{$fg[green]%}@%m%{$reset_color%}'
fi
local current_dir='%{$fg[yellow]%}$(hash -rdf; p="%~"; print -lr -- ${(%)p})%{$reset_color%}'
local git_prompt='$(my_git_prompt_info)'
local prompt_symbol='$(get_prompt_symbol)'

#setopt PROMPT_SUBST
PROMPT="
${user}${host} ${current_dir} ${git_prompt}
${prompt_symbol} "
RPROMPT='${vim_mode} ${return_code}'

#ZSH_THEME_GIT_PROMPT_PREFIX="${GIT_COLOR}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_DIVERGED="↕"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# vim: filetype=zsh

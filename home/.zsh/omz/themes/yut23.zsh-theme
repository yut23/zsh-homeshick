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
	#if [[ $KEYMAP == 'vicmd' ]] ; then tput cbb 2>/dev/null; else tput cbl 2>/dev/null; fi
}
zle -N zle-keymap-select

function zle-line-finish {
	vim_mode=$vim_ins_mode
	#tput cbl 2>/dev/null
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
	vim_mode=$vim_ins_mode
	#tput cbl 2>/dev/null
	return $(( 128 + $1 ))
}


function my_git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	GIT_STATUS=$(git_prompt_status)
	[[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_update_pretty_PWD {
	pretty_PWD=$(hash -rd; print -lr -- ${(%)PWD})
}
chpwd_functions+=(my_update_pretty_PWD)
my_update_pretty_PWD
local current_dir='%{$terminfo[bold]$fg[cyan]%} ${pretty_PWD}%{$reset_color%}'

#setopt PROMPT_SUBST
PROMPT='
%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[yellow]%}${current_dir}%{$reset_color%} $(my_git_prompt_info)
$ '
RPROMPT='${vim_mode} ${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="\~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# vim: filetype=zsh

# ~/.zsh/plugins.zsh

# needed for safe-paste to add its binding to the right keymap, on zsh < 5.1
bindkey -v
# don't automatically run multiline pastes
if [[ $HOST != ZB<->-host ]]; then
  #zinit ice wait lucid
  zinit snippet OMZ::plugins/safe-paste
else
  # zsh-bench compatible version for zsh >= 5.1
  set zle_bracketed_paste  # Explicitly restore this zsh default
  autoload -Uz bracketed-paste-magic
  zle -N bracketed-paste bracketed-paste-magic
fi

zinit load zsh-users/zsh-history-substring-search
if ! [[ $ZSH_XTRACE_RC -gt 0 ]] ; then
  # disable asynchronous plugins if profiling startup
  zinit ice wait'0' lucid
  zinit load zdharma-continuum/history-search-multi-word

  # node version manager
  zinit ice wait'1' lucid has'npm'
  zinit load lukechilds/zsh-nvm
  # and completion
  zinit ice wait'1' lucid has'npm'
  zinit load lukechilds/zsh-better-npm-completion

  zinit ice wait'1' lucid has'keybase'
  zinit load fnoris/keybase-zsh-completion

  zinit ice wait'1' lucid has'conda'
  zinit load esc/conda-zsh-completion
fi

# treat hyphen as a normal character, rather than lua's non-greedy *
export _ZL_HYPHEN=1
zinit ice has'lua'
zinit light skywind3000/z.lua

# automatically run .autoenv.zsh scripts on cd
AUTOENV_FILE_LEAVE=.autoenv.zsh
zinit ice nocompletions
zinit light Tarrasch/zsh-autoenv

# use my much-faster `pipenv --venv` script
zinit ice has'virtualenv' has'pwgen' \
  subst'pipenv --venv -> ~/bin/lib/get_pipenv_venv.py'
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

# replace any existing TPM-managed repo with a link to ours
zinit ice atclone'rm -rf ~/.tmux/plugins/tmux-update-env; ln -s -T "$PWD" ~/.tmux/plugins/tmux-update-env'
zinit light yut23/tmux-update-env

# load local plugins:
# * smart-cd: runs ls and git status after cd
zinit light "$HOME/.zsh/plugins/smart-cd"

# homeshick completion
if [[ ! -f $ZINIT[COMPLETIONS_DIR]/_homeshick ]]; then
  zinit creinstall %HOME/.homesick/repos/homeshick/completions
fi

# load ssh-ident
if [[ $system_name == frontier ]]; then
  # python gets loaded asynchronously
  local ssh_ident_ice=()
else
  local ssh_ident_ice=(has'python')
fi
zinit ice as'program' pick'bin/s*' "${ssh_ident_ice[@]}"
zinit light yut23/ssh-ident

# this must load after the last completion-related plugin
if ! [[ $ZSH_XTRACE_RC -gt 0 ]] ; then
  # disable asynchronous plugins if profiling startup
  zinit ice wait'1' lucid as'null' id-as'zsh-compinit-null' nocd \
    atload'zicdreplay'
  zinit light zdharma-continuum/null

  local default_conda_env
  case $system_name in
    blackwidow|xrb)
      default_conda_env=base
      ;;
    mandelbrot)
      default_conda_env=main
      ;;
    #summit)  # activated earlier in ~/.zsh/summit/misc.zsh
    #  default_conda_env=/ccs/proj/$PROJID/$USER/mambaforge_ppc64le/envs/summit
    #  ;;
    frontier)
      default_conda_env=/ccs/proj/$PROJID/$USER/mambaforge_x86_64/envs/frontier
      ;;
    andes)
      default_conda_env=/ccs/proj/$PROJID/$USER/mambaforge_x86_64/envs/andes_mamba
      ;;
    perlmutter)
      default_conda_env=pm
      ;;
    *)
      default_conda_env=
      ;;
  esac
  if [[ -n "$default_conda_env" ]]; then
    zinit ice wait'0' lucid as'null' id-as'conda-activate' has'conda' nocd \
      atload"conda activate '$default_conda_env'"
    zinit light zdharma-continuum/null
  fi

  zinit ice wait'2' lucid as'null' id-as'stop-scheduler' nocd \
    atload'stop-zinit-scheduler'
  zinit light zdharma-continuum/null
fi

# set theme stuff up now that we don't use OMZ
fpath=($HOME/.zsh/themes $fpath)
autoload -U promptinit && promptinit
autoload -U colors && colors
prompt yut23

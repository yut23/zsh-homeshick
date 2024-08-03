# zsh dotfiles

I use [homeshick](https://github.com/andsens/homeshick) for dotfile management, with my castles stored on GitHub (https://github.com/stars/yut23/lists/homeshick-castles).

I'm using GRML's zshrc as a base, with some minor modifications (mostly stripping out stuff I don't use).

## Load sequence

The original file layout was inspired by https://github.com/seebi/zshrc, but has evolved considerably since I first started.

Common config files are stored in `~/.zsh/`, while host-specific ones are in `~/.zsh/$system_name/` and are sourced immediately after the corresponding common ones.


1. ~/.zshrc.pre
  1. extracts autotmux overrides out of `$TERM` (used later in `~/.zshrc.local`, set by https://github.com/yut23/ssh-ident)
  2. adjusts GRML settings
  3. loads Zinit
  4. patches `@zinit-scheduler` to remove the chpwd hook
2. ~/.zshrc (GRML)
3. ~/.zshrc.local
  1. sets `$HOSTNAME`, with an optional override in `~/.hostname`
  2. sources `~/.zsh/system_name.zsh` to set `$system_name`, which determines what system I'm on for all host-specific configuration
  3. sources `~/.zsh/paths.zsh` and `~/.zsh/$system_name/paths.zsh`
  4. sources `~/.zsh/$system_name/modules.zsh` if present and modules haven't been loaded before (`modules.zsh` can clear the loaded flag if needed)
  5. sources `~/.tmux/autotmux.zsh`, which will exec into a shared tmux session if connected through ssh (or explicitly requested)
  6. loads homeshick
  7. sources all the other config files
4. paths.zsh (loaded above)
  - sets up `$PATH`
5. modules.zsh (loaded above)
  - loads any environment modules needed
6. env.zsh
7. aliases.zsh
8. history.zsh
9. misc.zsh
10. plugins.zsh
  - zinit
  - prompt
11. keys.zsh
12. private.zsh


## Conda/Mamba environments

* `conda init` and `mamba init` code goes in per-system `paths.zsh`
* activating the default environment is handled in `plugins.zsh`

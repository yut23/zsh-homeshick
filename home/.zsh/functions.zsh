#!/bin/zsh
# ~/.zsh/misc.zsh

# lifted from oh-my-zsh
function take() {
  mkdir -p $1
  cd $1
}

function installtexdoc() {
  tllocalmgr installdoc "$@"
  sudo texhash
}

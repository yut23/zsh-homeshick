# ~/.zsh/functions.zsh

# lifted from oh-my-zsh
function take() {
  mkdir -p $1
  cd $1
}

function installtexdoc() {
  tllocalmgr installdoc "$@"
  sudo texhash
}

function spim() {
  if [ $# -gt 0 ]; then
    command spim -file "$@"
  else
    command spim
  fi
}

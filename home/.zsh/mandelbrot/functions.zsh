# ~/.zsh/mandelbrot/functions.zsh

function asf() {
  ssh -n gauss -- /usr/bin/http -b POST :1242/Api/Command/\"$*\" | jq -r '.Result'
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

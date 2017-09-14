# ~/.zsh/mandelbrot/functions.zsh

function asf() {
  ssh home -- /usr/bin/asf --client --path=/var/lib/asf \"$*\"
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

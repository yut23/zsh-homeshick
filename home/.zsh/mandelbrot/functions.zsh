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

function pip-duplicates() {
  (export LC_COLLATE=C; echo 'package,global,user'; join -t, -j 1 <(env HOME=/ pip --no-cache-dir --disable-pip-version-check freeze --all | sed 's/==/,/' | sort) <(pip --no-cache-dir --disable-pip-version-check freeze --all --user | sed 's/==/,/' | sort) | env LC_COLLATE=C sort) | csvlook
}

#!/bin/zsh
# ~/.zsh/mandelbrot/functions.zsh

function asf() {
  ssh home -- /usr/bin/asf --client --path=/var/lib/asf \"$*\"
}

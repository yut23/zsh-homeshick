#!/bin/zsh
# ~/.zsh/mandelbrot/functions.zsh

function asf() {
  ssh home -- mono ~/asf/ASF.exe --path=/home/eric/asf --client "$@"
}

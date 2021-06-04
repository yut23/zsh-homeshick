# ~/.zsh/mandelbrot/env.zsh

# For Besiege development
export BESIEGE_LOCATION="$HOME/Games/Besiege/"

# For Android development
export ANDROID_HOME=/opt/android-sdk

# nvim debugging
#export ASAN_OPTIONS="detect_leaks=0:log_path=$HOME/logs/asan"
#export UBSAN_OPTIONS=print_stacktrace=1

export CASTRO_HOME="$HOME/school/research/Castro"
export AMREX_HOME="$HOME/school/research/amrex"

# fix urxvt segfault on exit (https://www.reddit.com/r/archlinux/comments/htq7hk)
export PERL_DESTRUCT_LEVEL=2

# look up entire directory tree for a Pipenv file
export PIPENV_MAX_DEPTH=50

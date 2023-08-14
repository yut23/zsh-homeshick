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

function zoom_arrange() {
  # arranges zoom windows on the second monitor (good for office hours)
  local side_width=355 margin=16 part_height=350

  if ((side_width<330)); then side_width=330; fi
  if ((part_height<300)); then part_height=300; fi

  local top_margin=$((margin + 26))  # window decoration height
  local chat_y=$((top_margin + part_height + top_margin))
  local main_x=$((margin + side_width + margin))

  local mon_width mon_height mon_x mon_y
  sleep 0.2
  read -r mon_width mon_height mon_x mon_y < <(xrandr --listmonitors </dev/null | perl -ne 'print if s/^ 1: \S+ (\d+)\/\d+x(\d+)\/\d+\+(\d+)\+(\d+) .*/\1 \2 \3 \4/')

  wmctrl -r 'Participants' -e 0,$((mon_x + margin)),$((mon_y + top_margin)),$side_width,$part_height
  wmctrl -r 'Participants' -b add,sticky,above
  wmctrl -r 'Participants' -t -1
  wmctrl -F -r 'Chat' -e 0,$((mon_x + margin)),$((mon_y + chat_y)),$side_width,$((mon_height - chat_y - margin))
  wmctrl -F -r 'Chat' -b add,sticky,above
  wmctrl -F -r 'Chat' -t -1
  wmctrl -F -r 'Zoom Meeting' -e 0,$((mon_x + main_x)),$((mon_y + top_margin)),$((mon_width - main_x - margin)),$((mon_height - top_margin - margin))
  wmctrl -F -r 'Zoom Meeting' -b add,sticky,above
  wmctrl -F -r 'Zoom Meeting' -t -1
}

function duplicacy-changes() {
  local repo=$1
  pushd -q ~/duplicacy
  if ! [[ -d $repo ]]; then
    echo "$PWD/$repo: $(errno ENOENT | cut -d' ' -f3-)."
    return 2
  fi
  ~/duplicacy/scripts/backup -n $repo | tee /tmp/duplicacy_$repo.log && \
    ~/projects/backup/duplicacy_to_ncdu.py /tmp/duplicacy_$repo.log | ncdu -f -
}
compdef '_files -W ~/duplicacy -/ -F "*scripts"' duplicacy-changes

#!/bin/sh
alacritty_class="AlacrittyScratchpad"
session_name="scratch"

# create session if not exists
tmux has-session -t "${session_name}"
if [ "$?" != "0" ]; then
  tmux -f $HOME/.config/tmux.conf \
    new-session -d -s "${session_name}"
fi

# figure out if scrachpad is open
xdo pid -N "${alacritty_class}"

# toggle depending on state
if [ "$?" = "0" ]; then
  xdo kill -N "${alacritty_class}"
else
  setsid alacritty --class "${alacritty_class},${alacritty_class}" \
    -e tmux a -t ${session_name} &
fi

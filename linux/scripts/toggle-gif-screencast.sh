#!/bin/bash

send_notification () {
  notify-send -h string:x-canonical-private-synchronous:gif_screencast "GIF Screencast" "$1"
}

on_cancel_recording () {
  send_notification "Area wasn't selected. Recording is cancelled."
  exit 1
}

# if recording is already running then stop it
if pgrep ffmpeg > /dev/null ; then
  killall -INT ffmpeg
  exit 0
fi

# otherwise start new recording
TMP_AVI=$(mktemp /tmp/screencast_XXXXXXXXXX.avi)
GIF_OUTPUT_NAME=~/Desktop/screencast_$(date +%d-%m-%y_%H-%M-%S).gif

send_notification "Please, select area to record"

# source: https://github.com/naelstrof/slop#practical-applications
slop=$(slop -f "%x %y %w %h %g %i") || on_cancel_recording
read -r X Y W H G ID < <(echo $slop)

send_notification "Recording..."

# stop compositor to prevent transparency artifacts
killall picom

ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -codec:v huffyuv -framerate 15 -y "${TMP_AVI}"

# start compositor after recording is done
setsid picom &

send_notification "Stopped. Converting to GIF"

gifgen -sf 15 -o "${GIF_OUTPUT_NAME}" "${TMP_AVI}"

rm -f "${TMP_AVI}"

send_notification "Done. Saved as ~/${GIF_OUTPUT_NAME#/home/*/}"

#!/bin/bash

TMP_AVI=$(mktemp /tmp/screencast_XXXXXXXXXX.avi)
GIF_OUTPUT_NAME=~/Desktop/screencast_$(date +%d-%m-%y_%H-%M-%S).gif

echo "After area selection recording will start. Press q to stop"

# source: https://github.com/naelstrof/slop#practical-applications
slop=$(slop -f "%x %y %w %h %g %i") || exit 1
read -r X Y W H G ID < <(echo $slop)
ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y -codec:v huffyuv -framerate 15 -y "${TMP_AVI}"

gifgen -sf 15 -o "${GIF_OUTPUT_NAME}" "${TMP_AVI}"

echo "Screencast saved at ${GIF_OUTPUT_NAME}"

rm -f "${TMP_AVI}"

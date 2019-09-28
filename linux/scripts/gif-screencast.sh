#!/bin/sh

# source https://unix.stackexchange.com/questions/113695/gif-screencasting-the-unix-way

TMP_AVI=$(mktemp /tmp/outXXXXXXXXXX.avi)
GIF_OUTPUT_NAME=~/Desktop/screencast_$(date +%d-%m-%y_%H-%M-%S).gif

echo "Starting recording... Press q to stop"

ffcast -s % ffmpeg -y -f x11grab -show_region 1 -framerate 15 \
    -video_size %s -i %D+%c -codec:v huffyuv                  \
    -vf crop="iw-mod(iw\\,2):ih-mod(ih\\,2)" $TMP_AVI

convert -set delay 10 -layers Optimize "${TMP_AVI}" "${GIF_OUTPUT_NAME}"
echo "Screencast saved at ${GIF_OUTPUT_NAME}"

rm -f "${TMP_AVI}"

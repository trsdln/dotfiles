#!/bin/dash

FILE_NAME="/tmp/screenshot_$(date +%d-%m-%y_%H-%M-%S).png"

# make screenshot
ffcast -s png "${FILE_NAME}"

# copy to clipboard
xclip -selection clipboard -t image/png -i "${FILE_NAME}"

rm -f "${FILE_NAME}"

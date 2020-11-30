#!/bin/sh

killall picom

if [ "$1" = "clipboard" ]; then
  maim -s | xclip -selection clipboard -t image/png
else
  screenshot_file="Desktop/screenshot_$(date +%d-%m-%y_%H-%M-%S).png"
  notify-send -h string:x-canonical-private-synchronous:take_screenshot \
    "Screenshot to $1" "Saving as $screenshot_file"

  maim -s > $HOME/$screenshot_file
fi

picom -b

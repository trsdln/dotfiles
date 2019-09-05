#!/bin/dash

# Pass file name as first argument to this script
NEW_WALLPAPER=$1

feh --bg-scale "${NEW_WALLPAPER}"
notify-send "Wallpaper Changed" "${NEW_WALLPAPER}"

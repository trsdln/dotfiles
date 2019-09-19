#!/bin/sh

# Pass file name as first argument to this script
NEW_WALLPAPER=$1

feh --bg-scale "${NEW_WALLPAPER}"
notify-send -h string:x-canonical-private-synchronous:wallpaper_change "Wallpaper Changed" "${NEW_WALLPAPER}"

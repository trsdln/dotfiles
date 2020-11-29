#!/bin/sh

WALLPAPER_CONFIG=$HOME/.local/share/wallpaper.txt

if [ -n "$1" ]; then
  rm -f "$WALLPAPER_CONFIG"
  echo "$1" > "$WALLPAPER_CONFIG"
  notify-send -h string:x-canonical-private-synchronous:wallpaper_change "Wallpaper Changed" "$1"
fi

if [ -f "$WALLPAPER_CONFIG" ]; then
  xwallpaper --zoom "$(cat "$WALLPAPER_CONFIG")"
fi

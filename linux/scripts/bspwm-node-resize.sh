#!/bin/sh

# slightly improved version of
# https://github.com/Chrysostomus/bspwm-scripts/blob/master/bin/bspwm_resize.sh
# (no grep usage)

size=${2:-'10'}
dir=$1

bspc query -N -n 'focused.tiled'
is_current_node_tiled="$?"

# If the window is floating, move it
if [ "$is_current_node_tiled" != "0" ]; then
  #only parse input if window is floating,tiled windows accept input as is
  case "$dir" in
    west) switch="-w"
      sign="-"
      ;;
    east) switch="-w"
      sign="+"
      ;;
    north) switch="-h"
      sign="-"
      ;;
    south) switch="-h"
      sign="+"
      ;;
  esac
  xdo resize ${switch} ${sign}${size}
else
  # Otherwise, window is tiled: switch with window in given direction
  case "$dir" in
    west) bspc node @west -r -$size || bspc node @east -r -${size}
      ;;
    east) bspc node @west -r +$size || bspc node @east -r +${size}
      ;;
    north) bspc node @south -r -$size || bspc node @north -r -${size}
      ;;
    south) bspc node @south -r +$size || bspc node @north -r +${size}
      ;;
  esac
fi

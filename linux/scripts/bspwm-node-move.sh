#!/bin/bash

# Based on https://gitlab.com/protesilaos/cpdfd/-/blob/master/bin/bin/bspwm_smart_move
# Added floating windows support

# If there is a window in the given direction,
# swap places with it.  Else if there is a receptacle move to it
# ("consume" its place).  Otherwise create a receptacle in the given
# direction by splitting the entire viewport (circumvents the tiling
# scheme while respecting the current split ratio configuration).  In
# the latter scenario, inputting the direction twice will thus move the
# focused window out of its current layout and into the receptacle.

dir="$1"

_query_nodes() {
	bspc query -N -n "$@"
}

_query_nodes focused.floating
is_floating="$?"

if [ "$is_floating" = "0" ]; then
  case "$dir" in
    west)
      diff_xy="-20 0"
      ;;
    south)
      diff_xy="0 20"
      ;;
    north)
      diff_xy="0 -20"
      ;;
    east)
      diff_xy="20 0"
      ;;
  esac
  bspc node -v ${diff_xy}
  exit 0
fi

receptacle="$(_query_nodes 'any.leaf.!window')"

# This regulates the behaviour documented in the description.
if [ -n "$(_query_nodes "${dir}.!floating")" ]; then
	bspc node -s "$dir"
elif [ -n "$receptacle" ]; then
	bspc node focused -n "$receptacle" --follow
else
	bspc node @/ -p "$dir" -i && bspc node -n "$receptacle" --follow
fi

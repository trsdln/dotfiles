#!/bin/sh

PANEL_FIFO=/tmp/panel-fifo
PANEL_FONT="Hack:style=bold:antialias=true:size=10"
PANEL_FONT_ICON="Noto Color Emoji:antialias=true:size=10"
PANEL_WM_NAME=bspwm_lemonbar

SEP="  " # widgets separator

# ALPHA_BG="E6"
ALPHA_BG="EA"

apply_alpha(){
  echo "#${ALPHA_BG}${1#?}"
}

wrap_self_edit(){
  local script_name="${0##*/}"
  local widget_name="${script_name%\.sh}"
  echo "%{A2:widg-act e ${widget_name}:}$1%{A2}"
}

# one dark pro
RED_COLOR="#df6b74"
CYAN_COLOR="#4b97a3"
YELLOW_COLOR="#d19a66"
BLUE_COLOR="#5fabe9"
GREEN_COLOR="#94be76"
MAGENTA_COLOR="#c678dd"
WHITE_COLOR="#d6d6d6"
GRAY_COLOR="#7e838d"
BLACK_COLOR="#282c34"

COLOR_DEFAULT_FG="${WHITE_COLOR}"
COLOR_DEFAULT_BG=$(apply_alpha "${BLACK_COLOR}")

# monitor
COLOR_MONITOR_FG="${BLUE_COLOR}"
COLOR_MONITOR_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_FOCUSED_MONITOR_FG="${RED_COLOR}"
COLOR_FOCUSED_MONITOR_BG=$(apply_alpha "${BLACK_COLOR}")

# workspace
COLOR_FREE_FG="${GRAY_COLOR}"
COLOR_FREE_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_FOCUSED_FREE_FG="${MAGENTA_COLOR}"
COLOR_FOCUSED_FREE_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_OCCUPIED_FG="${BLUE_COLOR}"
COLOR_OCCUPIED_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_FOCUSED_OCCUPIED_FG="${RED_COLOR}"
COLOR_FOCUSED_OCCUPIED_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_URGENT_FG="${YELLOW_COLOR}"
COLOR_URGENT_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_FOCUSED_URGENT_FG="${BLACK_COLOR}"
COLOR_FOCUSED_URGENT_BG=$(apply_alpha "${YELLOW_COLOR}")

# wm layout
COLOR_STATE_FG="${GRAY_COLOR}"
COLOR_STATE_BG=$(apply_alpha "${BLACK_COLOR}")
COLOR_TITLE_FG="${WHITE_COLOR}"
COLOR_TITLE_BG=$(apply_alpha "${BLACK_COLOR}")

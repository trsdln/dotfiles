#!/bin/sh

# based on https://github.com/mellok1488/dotfiles/blob/master/panel

# Kill old instance first
# pgrep is not able to find process if whole process name is specified :facepalm:
old_instance_pid=$(pgrep 'statusline-star' | grep -v $$ | sort | head -n 1)
if [ "${old_instance_pid}" != "" ]; then
  pkill -P "${old_instance_pid}"
fi

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/statusline/configs.sh
. $SCRIPTS_DIR/statusline/format.sh

WIDGETS_DIR="$SCRIPTS_DIR/statusline/widgets"

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

# wm state
bspc subscribe report > "$PANEL_FIFO" &

# current window title
xtitle -sf 'T%s\n' > "$PANEL_FIFO" &

# MPRIS info
playerctl -F -f '{{status}}%%{{title}}' metadata \
  | $WIDGETS_DIR/player.sh > "$PANEL_FIFO" &

# those are updated manually when needed:
# (call once to get only initial values)
$WIDGETS_DIR/watch-later.sh &
$WIDGETS_DIR/language.sh &

while true; do
  $WIDGETS_DIR/clock.sh
  sleep 15
done &

while true; do
  $WIDGETS_DIR/cpu-temp.sh
  $WIDGETS_DIR/network.sh
  $WIDGETS_DIR/battery.sh
  sleep 60
done &

format_panel_info < "$PANEL_FIFO" | \
  lemonbar -a 64 -n "$PANEL_WM_NAME" \
  -f "$PANEL_FONT" -f "$PANEL_FONT_ICON" \
  -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" | sh &

# prevent lemonbar from overlapping fullscreen windows
wids=$(xdo id -a "$PANEL_WM_NAME")
tries_left=20
while [ -z "$wid" -a "$tries_left" -gt 0 ] ; do
	sleep 0.05
	wids=$(xdo id -a "$PANEL_WM_NAME")
	tries_left=$((tries_left - 1))
done
if [ -n "$wids" ]; then
  IFS='
  '
  set -- ${wids}
  # handle every window instance
  while [ $# -gt 0 ]; do
    xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$1"
    shift
  done
fi

trap panel_cleanup INT TERM QUIT EXIT
panel_cleanup() {
  pkill -P $$
  exit 0
}

wait

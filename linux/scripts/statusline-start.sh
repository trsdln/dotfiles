#!/bin/sh

# based on https://github.com/mellok1488/dotfiles/blob/master/panel

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/statusline/configs.sh
. $SCRIPTS_DIR/statusline/format.sh

if xdo id -a "$PANEL_WM_NAME" > /dev/null ; then
  printf "%s\n" "The panel is already running." >&2
  exit 1
fi

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

bspc subscribe report > "$PANEL_FIFO" &


# title
xtitle -sf 'T%s\n' > "$PANEL_FIFO" &

# clock
while true; do
  statusline-update.sh
  sleep 30
done &

format_panel_info < "$PANEL_FIFO" | \
  lemonbar -a 32 -n "$PANEL_WM_NAME" \
  -f "$PANEL_FONT" -f "$PANEL_FONT_ICON" \
  -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" | sh &

# prevent lemonbar from overlapping fullscreen windows
wid=$(xdo id -a "$PANEL_WM_NAME")
tries_left=20
while [ -z "$wid" -a "$tries_left" -gt 0 ] ; do
	sleep 0.05
	wid=$(xdo id -a "$PANEL_WM_NAME")
	tries_left=$((tries_left - 1))
done
[ -n "$wid" ] && xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

trap panel_cleanup INT TERM QUIT EXIT
panel_cleanup() {
  pkill -P $$
  exit 0
}

wait

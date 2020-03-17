#!/bin/sh

# based on https://github.com/mellok1488/dotfiles/blob/master/panel

LEMONBAR_DIR=$(dirname "$0")
. $LEMONBAR_DIR/configs.sh
. $LEMONBAR_DIR/update_info.sh
. $LEMONBAR_DIR/format.sh

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
  lemonbar_update_info
  sleep 30
done &

format_panel_info < "$PANEL_FIFO" | \
  lemonbar -a 32 -n "$PANEL_WM_NAME" \
  -f "$PANEL_FONT" -f "$PANEL_FONT_ICON" \
  -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" | sh &

trap panel_cleanup INT TERM QUIT EXIT
panel_cleanup() {
  pkill -P $$
  exit 0
}

wait

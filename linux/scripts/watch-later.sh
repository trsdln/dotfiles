#/bin/sh

watch_later_file=$HOME/.local/share/watch-later.m3u

cmd=$1

notification_title="Watch Later"
notification_hint="string:x-canonical-private-synchronous:watch-later"

if [ $cmd = "add" ]; then
  title=$(youtube-dl --skip-download --get-title --no-warnings "$2")
  echo "#EXTINF:, ${title}" >> $watch_later_file
  echo $2 >> $watch_later_file
  statusline-update.sh
  notify-send --hint $notification_hint "$notification_title" "'${title}' added"
elif [ $cmd = "clear" ]; then
  rm -rf $watch_later_file
  statusline-update.sh
  notify-send --hint $notification_hint "$notification_title" "Cleaned!"
elif [ $cmd = "play" ]; then
  notify-send --hint $notification_hint "$notification_title" "Starting mpv..."
  exec mpv $watch_later_file
elif [ $cmd = "count" ]; then
  items_count=$(wc -l $watch_later_file 2> /dev/null)
  # strip file name
  items_count=${items_count%% *}
  # fall back to 0 as default
  items_count=${items_count:-0}
  # account for video titles
  items_count=$((${items_count} / 2))
  echo "$items_count"
elif [ $cmd = "edit" ]; then
  $TERMINAL -e $EDITOR $watch_later_file
fi

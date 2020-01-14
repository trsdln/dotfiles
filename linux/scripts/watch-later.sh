#/bin/sh

watch_later_file=$HOME/.local/share/watch-later.txt

cmd=$1

notification_title="Watch Later"
notification_hint="string:x-canonical-private-synchronous:watch-later"

if [ $cmd = "add" ]; then
  echo $2 >> $watch_later_file
  notify-send --hint $notification_hint "$notification_title" "$2 added"
elif [ $cmd = "clear" ]; then
  rm -rf $watch_later_file
  notify-send --hint $notification_hint "$notification_title" "Cleaned!"
elif [ $cmd = "play" ]; then
  notify-send --hint $notification_hint "$notification_title" "Starting mpv..."
  exec mpv --playlist=$watch_later_file
fi

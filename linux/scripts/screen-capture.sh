#!/bin/bash

echoerr() { echo "$@" 1>&2; }

start_compositor() {
  picom -b &
}

stop_compositor() {
  killall picom
}

send_notification () {
  notify-send -h string:x-canonical-private-synchronous:screen_capture "Screen Capture" "$1"
}

file_timestamp() {
  date +%d-%m-%y_%H-%M-%S
}

on_cancel_recording () {
  send_notification "Area wasn't selected. Recording is cancelled."
  exit 1
}

GIF_SPECIFIC_FFMPEG_FLAGS="-codec:v huffyuv -framerate 15"
record_video() {
  local mode=$1 # gif | mp4
  local audio=$2 # record audio if equals "audio"

  local output_file="Desktop/screencast_$(file_timestamp).${mode}"
  local output_file_full=$HOME/$output_file

  send_notification "Please, select area to record"

  # source: https://github.com/naelstrof/slop#practical-applications
  slop=$(slop -f "%x %y %w %h %g %i") || on_cancel_recording
  read -r X Y W H G ID < <(echo $slop)

  # stop compositor to prevent transparency artifacts
  stop_compositor

  send_notification "Recording... (Press Ctrl+Print to stop)"

  local extra_flags=$([ "${mode}" = "gif" ] && echo "$GIF_SPECIFIC_FFMPEG_FLAGS" || echo "")
  local ffmpeg_output=$([ "${mode}" = "gif" ] && mktemp /tmp/screencast_XXXXXXXXXX.avi || echo "$output_file_full")
  # hw:0 means first device at `arecord -l` list
  local audio_flags=$([ "${audio}" = "audio" ] && echo "-f alsa -i hw:0" || echo "")

  ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y ${extra_flags} ${audio_flags} -y "${ffmpeg_output}"

  start_compositor

  send_notification "Stopped. Converting to GIF"

  if [ "$mode" = "gif" ]; then
    gifgen -sf 15 -o "${output_file_full}" "${ffmpeg_output}"
    rm -f "${ffmpeg_output}"
  fi

  send_notification "Screencast saved as ~/${output_file}"
}

stop_recording() {
  killall -INT ffmpeg
}

take_screenshot() {
  stop_compositor

  sleep 1 # prevents random black screen while selecting area

  if [ "$1" = "clipboard" ]; then
    maim -s | xclip -selection clipboard -t image/png
  else
    local screenshot_file="Desktop/screenshot_$(file_timestamp).png"
    local screenshot_file_full="$HOME/$screenshot_file"

    maim -s > $screenshot_file_full
    maim_res=$?

    if [ "$maim_res" = "0" ]; then
      send_notification "Saved as ~/$screenshot_file"
    else
      send_notification "Canceled"
      rm -f $screenshot_file_full
    fi
  fi

  start_compositor
}

print_menu_options() {
  echo "Record mp4
Record GIF
Record mp4+audio
Screenshot File
Screenshot Clipboard
"
}

capture_menu() {
  local selected=$(print_menu_options | dmenu -i -p "Mode>")

  case "${selected}" in
    Record\ mp4) record_video mp4 ;;
    Record\ mp4+audio) record_video mp4 audio;;
    Record\ GIF) record_video gif ;;
    Screenshot\ File) take_screenshot file ;;
    Screenshot\ Clipboard) take_screenshot clipboard ;;
    *) echoerr "No option selected" ;;
  esac
}

cmd=$1
shift

case $cmd in
  record) record_video $1 $2 ;;
  stop) stop_recording ;;
  screenshot) take_screenshot $1 ;;
  menu) capture_menu ;;
  *)
    echoerr "Error: Unknown command '$cmd'"
    exit 1
    ;;
esac


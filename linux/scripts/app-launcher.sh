#!/bin/sh

print_app_options () {
echo "Google Chrome:chromium
Alacritty Terminal:alacritty
Telegram:telegram-desktop
Slack:slack
Thunderbird Email:thunderbird
Hubstuff:hubsuff
MongoDB Compass:mongodb-compass
Robo3T:robo3t
Transmission Torrent:transmission-qt
Android File Transfer:android-file-transfer
Gimp:gimp"
}

prompt_app_and_run () {
  local selected_option=$(print_app_options | cut -d ':' -f1 | dmenu -i -l 20 -p 'Launch App')
  local run_cmd=$(print_app_options | grep "${selected_option}" | cut -d ':' -f2)

  "${run_cmd}" &
}

prompt_app_and_run

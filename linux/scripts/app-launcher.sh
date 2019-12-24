#!/bin/sh

print_app_options () {
echo "Google Chrome:chromium
Chromium Incognito:chromium --incognito
Alacritty Terminal:alacritty
Telegram:telegram-desktop
Slack:slack
Htop:alacritty -e htop
Newsboat:alacritty -e newsboat
Tuijam:alacritty -e tuijam
Thunderbird Email:thunderbird
MongoDB Compass:mongodb-compass
Robo3T:robo3t
Transmission Torrent:transmission-qt
Android File Transfer:android-file-transfer
Gimp:gimp"
}

prompt_app_and_run () {
  local selected_option="$(print_app_options | cut -d ':' -f1 | dmenu -i -l 20 -p 'Launch App')"

  if [ "${selected_option}" != "" ]; then
    local run_cmd="$(print_app_options | grep "${selected_option}" | cut -d ':' -f2)"

    ${run_cmd} &
  fi
}

prompt_app_and_run

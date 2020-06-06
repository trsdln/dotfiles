#!/bin/sh

tmux_new () {
  $TERMINAL -e tmux -f $HOME/.config/tmux.conf &
}

tmux_attach () {
  local picked_session_id=$(tmux ls | dmenu -i -l 5 -p 'Session>' | cut -d ":" -f 1)
  if [ -n "${picked_session_id}" ]; then
    $TERMINAL -e tmux -f $HOME/.config/tmux.conf attach -t "${picked_session_id}" &
  fi
}

print_app_options () {
echo "Google Chrome:chromium
Chrome Incognito:chromium --incognito
TMUX New:tmux_new
TMUX Attach:tmux_attach
PulseMixer:$TERMINAL -e pulsemixer
Bluetoothctl:$TERMINAL -e bluetoothctl
Alacritty Terminal:$TERMINAL
Telegram:telegram-desktop
Slack:slack
Htop:$TERMINAL -e htop
Newsboat:$TERMINAL -e newsboat
Tuijam:$TERMINAL -e tuijam
MongoDB Compass:mongodb-compass
Robo3T:robo3t
Transmission Torrent:transmission-qt
Android File Transfer:android-file-transfer
Gimp:gimp
Hubstaff:hubstaff
Toggle Redshift:pkill -USR1 redshift
PassMenu:passmenu
Keybase:keybase-gui
Tor Browser:torbrowser-launcher
Play Watch Later:watch-later.sh play
Clear Watch Later:watch-later.sh clear
Edit Watch Later:watch-later.sh edit
Lock:power-manager.sh lock
Sleep:power-manager.sh sleep
Hibernate:power-manager.sh hibernate
Shutdown:power-manager.sh shutdown
Reboot:power-manager.sh reboot
Logout:power-manager.sh logout
"
}

prompt_app_and_run () {
  local selected_option="$(print_app_options | cut -d ':' -f1 | dmenu -i -p 'Launch App')"

  if [ "${selected_option}" != "" ]; then
    local run_cmd="$(print_app_options | grep "${selected_option}" | cut -d ':' -f2)"

    ${run_cmd} &
  fi
}

prompt_app_and_run

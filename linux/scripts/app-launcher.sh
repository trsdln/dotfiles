#!/bin/sh

export DOTFILES_PATH=$HOME/.dotfiles

tmux_new () {
  alacritty -e tmux -f $HOME/.config/tmux.conf &
}

tmux_attach () {
  local picked_session_id=$(tmux ls | dmenu -i -l 5 -p 'Session>' | cut -d ":" -f 1)
  if [ -n "${picked_session_id}" ]; then
    alacritty -e tmux -f $HOME/.config/tmux.conf attach -t "${picked_session_id}" &
  fi
}

print_app_options () {
echo "Google Chrome:chromium
Chrome Incognito:chromium --incognito
TMUX New:tmux_new
TMUX Attach:tmux_attach
PulseMixer:alacritty -e pulsemixer
Bluetoothctl:alacritty -e bluetoothctl
Alacritty Terminal:alacritty
Telegram:telegram-desktop
Slack:slack
Htop:alacritty -e htop
Newsboat:alacritty -e newsboat
Tuijam:alacritty -e tuijam
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
Clear Watch Later:watch-later.sh clear"
}

prompt_app_and_run () {
  local selected_option="$(print_app_options | cut -d ':' -f1 | dmenu -i -p 'Launch App')"

  if [ "${selected_option}" != "" ]; then
    local run_cmd="$(print_app_options | grep "${selected_option}" | cut -d ':' -f2)"

    ${run_cmd} &
  fi
}

prompt_app_and_run

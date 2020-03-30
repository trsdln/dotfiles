#!/bin/sh

export DOTFILES_PATH=$HOME/.dotfiles

print_app_options () {
echo "Google Chrome:chromium
Chrome Incognito:chromium --incognito
Tmux:alacritty -e tmux -f $HOME/.config/tmux.conf
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
passmenu:passmenu
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

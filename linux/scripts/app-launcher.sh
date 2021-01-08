#!/bin/sh

# ensure that all launched apps will use Zsh by default
export SHELL='/bin/zsh'

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
echo "Brave:brave
Brave Incognito:brave --incognito
TMUX New:tmux_new
TMUX Attach:tmux_attach
PulseMixer:$TERMINAL -e pulsemixer
Easy Mount:$TERMINAL -e easy-mount.sh lf
Bluetoothctl:$TERMINAL -e bluetoothctl
Alacritty Terminal:$TERMINAL
Telegram:telegram-desktop
Slack:slack
Htop:$TERMINAL -e htop
Newsboat:$TERMINAL -e newsboat
MongoDB Compass:mongodb-compass
Robo3T:robo3t
Transmission Torrent:transmission-gtk
Android File Transfer:android-file-transfer
Gimp:gimp
Hubstaff:hubstaff
Toggle Redshift:pkill -USR1 redshift
PassMenu Type:passmenu --type
PassMenu Copy:passmenu
bm-copy:bm copy-ui
bm-type:bm type-ui
bm-edit:bm edit-ui
bm-add:bm add-ui
Screen Capture:screen-capture.sh menu
Firefox:firefox
Tor Browser:torbrowser-launcher
Play Watch Later:watch-later.sh play
Clear Watch Later:watch-later.sh clear
Edit Watch Later:watch-later.sh edit
Steam:steam
Session:session
Lock:power-manager.sh lock
Sleep:power-manager.sh sleep
Hibernate:power-manager.sh hibernate
Shutdown:power-manager.sh shutdown
Reboot:power-manager.sh reboot
Logout:power-manager.sh logout
"
}

prompt_app_and_run () {
  local app_options=$(print_app_options | cut -d ':' -f1)
  local bookmark_options=$(bm list)
  local selected_option="$(printf "%s\n%s" "$app_options" "$bookmark_options" | dmenu -i -p 'Launch App')"

  if [ "${selected_option}" != "" ]; then
    local run_cmd="$(print_app_options | grep -F "${selected_option}:" | cut -d ':' -f2)"

    if [ "$run_cmd" = "" ]; then
      # probably bookmark was selected
      bm open "${selected_option}"
    else
      # execute command
      ${run_cmd} &
    fi
  fi
}

prompt_app_and_run

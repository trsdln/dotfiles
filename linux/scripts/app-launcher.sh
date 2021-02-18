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
echo "Browser:brave
Incognito:brave --incognito
TMUXNew:tmux_new
TMUXAttach:tmux_attach
PulseMixer:$TERMINAL -e pulsemixer
EasyMount:$TERMINAL -e easy-mount.sh lf
Bluetooth:$TERMINAL -e bluetoothctl
Alacritty:$TERMINAL
Telegram:telegram-desktop
Signal:signal-desktop
Slack:slack
Htop:$TERMINAL -e htop
Newsboat:$TERMINAL -e newsboat
Compass:mongodb-compass
Robo3T:robo3t
Transmission:transmission-gtk
Gimp:gimp
Hubstaff:hubstaff
Pass Type:passmenuotp show --type
Pass Copy:passmenuotp
Otp Type:passmenuotp otp --type
Otp Copy:passmenuotp otp
BM Copy:bm copy-ui
BM Type:bm type-ui
BM Edit:bm edit-ui
BM Add:bm add-ui
ScreenCapture:screen-capture.sh menu
Firefox:firefox
TorBrowser:torbrowser-launcher
Play WatchL:watch-later.sh play
Clear WatchL:watch-later.sh clear
Add WatchL:watch-later.sh add-xclip
Edit WatchL:watch-later.sh edit
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

#!/bin/sh

prompt_confirmation () {
  local prompt_message="$1"
  local prompt_action="$2"

  local answer=$(printf "No\nYes" | dmenu -i -p "$prompt_message")

  if [ "$answer" = 'Yes' ]; then
    $prompt_action
  fi
}

do_shutdown () {
  sudo shutdown -h now
}

do_reboot () {
  sudo shutdown -r now
}

do_logout() {
  bspc quit
}

SELECTED_COMMAND="$1"

case $SELECTED_COMMAND in
  lock) slock & ;;
  sleep) loginctl suspend ;;
  hibernate) loginctl hibernate ;;
  shutdown)   prompt_confirmation 'Shutting down now. Are you sure?' 'do_shutdown' ;;
  reboot) prompt_confirmation 'Rebooting now. Are you sure?' 'do_reboot' ;;
  logout) prompt_confirmation 'Logging out now. Are you sure?' 'do_logout' ;;
esac

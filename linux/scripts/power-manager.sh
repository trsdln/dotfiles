#!/bin/sh

OPTIONS="Lock\nSleep\nHibernate\nShutdown\nReboot"

SELECTED_OPTION=$(printf $OPTIONS | dmenu -i -p 'Action')

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

if [ "$SELECTED_OPTION" = 'Lock' ]; then
  slock &
fi

if [ "$SELECTED_OPTION" = 'Sleep' ]; then
  systemctl suspend
fi

if [ "$SELECTED_OPTION" = 'Hibernate' ]; then
  systemctl hibernate
fi

if [ "$SELECTED_OPTION" = 'Shutdown' ]; then
  prompt_confirmation 'Shutting down now. Are you sure?' 'do_shutdown'
fi

if [ "$SELECTED_OPTION" = 'Reboot' ]; then
  prompt_confirmation 'Rebooting now. Are you sure?' 'do_reboot'
fi

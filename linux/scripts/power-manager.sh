#!/bin/bash

OPTIONS="Sleep\nHibernate\nShutdown\nReboot"

SELECTED_OPTION=$(printf $OPTIONS | dmenu -i -p 'Action')

function prompt_confirmation {
  local prompt_message=$1
  local prompt_action=$2

  local answer=$(printf "No\nYes" | dmenu -i -p "$prompt_message")

  if [ "$answer" = 'Yes' ]; then
    $prompt_action
  fi
}

function do_shutdown {
  # sudo shutdown -h now
  echo "shutting down"
}

function do_reboot {
  # sudo shutdown -r now
  echo "rebooting..."
}

if [ "$SELECTED_OPTION" = 'Sleep' ]; then
  echo "Sleeping..."
  # sudo zzz
fi

if [ "$SELECTED_OPTION" = 'Hibernate' ]; then
  echo "hibernating..."
  # sudo ZZZ
fi

if [ "$SELECTED_OPTION" = 'Shutdown' ]; then
  prompt_confirmation 'Shutting down now. Are you sure?' 'do_shutdown'
fi

if [ "$SELECTED_OPTION" = 'Reboot' ]; then
  prompt_confirmation 'Rebooting now. Are you sure?' 'do_reboot'
fi

#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

format_player_wrapper() {
  echo "%{A:playerctl play-pause:}$(wrap_self_edit "${1}")%{A}"
}

format_player_info() {
  local mpris_status=${1}

  local player=""
  if [ "${mpris_status}" = "Playing" ]; then
    local player=$(format_player_wrapper "▶")
  elif [ "${mpris_status}" = "Paused" ]; then
    local player=$(format_player_wrapper "⏸")
  fi

  echo "${player}"
}

while read -r line ; do
  if [ "$line" = "" ]; then
    # when player is closed playerctl prints empty line,
    # so we must write "P" to refresh widget
    echo "P"
  else
    echo "P$(format_player_info "$line")"
  fi
done

#!/bin/sh

print_plugin_dates_for_dir() {
  local plugins_dir=$1
  for plugin in $(ls $plugins_dir); do
    cd "$plugins_dir/$plugin"
    local remote_url=$(git remote -v | head -n 1 | cut -d " " -f 1 | cut -f 2)
    printf "%s %-35s %-30s %s\n" "$(git log -1 --format=%cd --date=unix)" "$(git log -1 --format=%cd)" "$plugin" "${remote_url%????}"
  done
}

print_plugin_dates() {
  print_plugin_dates_for_dir ~/.config/nvim/pack/minpac/start
  print_plugin_dates_for_dir ~/.config/nvim/pack/minpac/opt
}

printf "%s\n" "$(print_plugin_dates | sort -n -)"

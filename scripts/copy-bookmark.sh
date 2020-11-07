#!/bin/bash

if [ "$OSTYPE" = "linux-gnu" ]; then
  fuzzy_finder=dmenu
else
  fuzzy_finder=sk
fi

selected=$("${fuzzy_finder}" < $DOTFILES_PATH/private/bookmarks.txt | cut -d "*" -f 2)

if [ "$OSTYPE" = "linux-gnu" ]; then
  echo "${selected}" | xclip -selection clipboard
  notify-send --hint=string:x-canonical-private-synchronous:bookmark \
  "Bookmark" "Copied into clipboard!"
else
  echo "${selected}" | pbcopy
fi



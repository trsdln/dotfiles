#!/bin/sh

# note: need to execute last command again in order to get UI visible
# $ exec electron /usr/share/keybase-app

keybase ctl stop
if [ -n "$HTTP_PROXY" ]; then
        export PROXY=$(echo $HTTP_PROXY | /usr/bin/sed 's?http://??' | /usr/bin/sed 's/[ \t\n][ \t\n]*$//')
        export PROXY_TYPE="http_connect"
fi
keybase ctl init
keybase --use-default-log-file --debug service &
rm -f ~/.config/keybase/autostart_created ~/.config/autostart/keybase_autostart.desktop
kbfsfuse -debug -log-to-file &
if [ -n "$DISPLAY" ]; then
        export KEYBASE_AUTOSTART=1
        electron /usr/share/keybase-app &
fi


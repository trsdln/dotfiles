#!/bin/sh

SCRIPTS_DIR=$(dirname "$0")
. $SCRIPTS_DIR/../configs.sh

echo "V%{A:watch-later.sh edit:}$(wrap_self_edit "📷 $(watch-later.sh count)")%{A}" > "${PANEL_FIFO}"

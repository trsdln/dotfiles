#!/bin/bash

# System rsync backup script
# Should be executed with sudo

# Config
SRC="/" # complete system backup
SNAP="/mnt/snapshots"
LAST="${SNAP}/last"
CURRENT="${SNAP}/current"

# Ensure correct backup drive is mounted
if [ -d "${SNAP}" ]; then
  # Find script location dir
  SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

  # Run rsync to create snapshot
  rsync --archive --hard-links --acls --xattrs \
    --human-readable --inplace --numeric-ids --delete \
    --delete-excluded --exclude-from=${SCRIPT_DIR}/system-backup-exclude.txt \
    --verbose --progress --itemize-changes \
    --link-dest=${LAST} \
    ${SRC} ${CURRENT}
else
  echo "Error: backup drive not found! (${SNAP})"
  exit 1
fi

RSYNC_EXIT_CODE=$?

if [ "${RSYNC_EXIT_CODE}" = "0" ]; then
  DATED_SNAP="${SNAP}/$(date "+%Y-%b-%d_%H-%M")"

  # tag current backup with date
  mv ${CURRENT} ${DATED_SNAP}

  # Remove symlink to previous snapshot
  rm -f ${LAST}

  # Create new symlink to latest snapshot for the next backup to hardlink
  ln -s ${DATED_SNAP} ${LAST}

  echo "Snapshot backup created: ${DATED_SNAP}"
else
  echo "Backup failed or interrupted"
fi

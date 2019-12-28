#!/bin/sh

# Based on http://ratfactor.com/slackware/mounty/

# display dialog menu with block device list where elements
# from array make choice,description pairs
selected=$(lsblk -l -p -n --output name,size,label,vendor,model | dmenu -l 10 -p "Select device to mount:" | awk '{print $1}')

if [ -z $selected ]
then
	echo "No device selected."
	exit
fi

# take chosen selection and see if it's already mounted
dir=$(findmnt --source $selected -n -o TARGET)
if [ -z $dir ]; then
  dir="/mnt"
  echo "Mounting $selected at $dir..."
  sudo mount $selected $dir || exit
else
  echo "$selected already mounted at $dir"
fi

# now that it's mounted, call user-supplied arguments
$1 $dir $2 $3 $4 $5

unmount_resp=$(printf "No\nYes" | dmenu -p "Do you want unmount '$selected'?")

if [ $unmount_resp = "Yes" ]; then
  echo "Now unmounting $selected..."
  sudo umount $selected
  unmount_result=$?
  if [ $unmount_result = 0 ]; then
    echo "Done."
  else
    echo "Failed to unmount: $selected"
  fi
else
  echo "Skipping unmounting"
fi

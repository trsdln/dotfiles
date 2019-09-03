#!/bin/bash

# Based on http://ratfactor.com/slackware/mounty/

# display dialog menu with block device list where elements
# from array make choice,description pairs
selected=$(lsblk -l -p -n --output name,size,label,vendor,model | dmenu -l 10 -p "Select device to mount:" | awk '{print $1}')

if [[ -z $selected ]]
then
	echo "No device selected."
	exit
fi

# take chosen selection and see if it's already mounted
#if findmnt $selected >/dev/null
if dir=$(findmnt --source $selected -n -o TARGET); then
	echo "$selected already mounted at $dir"
else
	dir="/mnt"
	echo "Mounting $selected at $dir..."
	sudo mount $selected $dir || exit
fi

# now that it's mounted, call user-supplied arguments
$1 $dir $2 $3 $4 $5
#echo "running:" $1 $dir $2 $3 $4 $5

unmount_resp=$(printf "No\nYes" | dmenu -p "Do you want unmount '$selected'?")

if [ $unmount_resp = "Yes" ]; then
  echo "Now unmounting $selected..."
  sudo umount $selected
else
  echo "Skipping unmounting"
fi

echo "Done."

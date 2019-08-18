#!/bin/bash

# Pass file name as first argument to this script

NEW_WALLPAPER=$1

# todo: handle different extensions
cp $NEW_WALLPAPER ~/Pictures/wallpaper.jpg

feh --bg-scale ~/Pictures/wallpaper.jpg

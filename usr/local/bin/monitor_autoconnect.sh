#!/bin/bash

xrandr | grep "HDMI-A-0 connected"
if [[ $? == 0 ]]; then
  # is connected
  xrandr --output HDMI-A-0 --right-of eDP --auto
  feh --bg-fill --randomize --recursive /mnt/shared-storage/Wallpapers
else
  # not connected
  xrandr --output HDMI-A-0 --auto
fi

xrandr | grep "VGA1 connected"
if [[ $? == 0 ]]; then
  # is connected
  xrandr --output VGA1 --right-of eDP --auto
  feh --bg-fill --randomize --recursive /mnt/shared-storage/Wallpapers
else
  # not connected
  xrandr --output VGA1 --auto
fi

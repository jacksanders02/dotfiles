#!/bin/bash
date > /home/jacksanders/.scripts/testexec
sleep 5
export HYPRLAND_INSTANCE_SIGNATURE=$(< /home/jacksanders/.config/hypr/instance-sig)
hyprctl dispatch moveworkspacetomonitor 1 HDMI-A-1
hyprctl dispatch moveworkspacetomonitor 2 HDMI-A-1
hyprctl dispatch moveworkspacetomonitor 3 HDMI-A-1
hyprctl dispatch moveworkspacetomonitor 4 HDMI-A-1
hyprctl dispatch moveworkspacetomonitor 5 HDMI-A-1

hyprctl dispatch exec hyprpaper

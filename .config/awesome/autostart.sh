#!/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run "redshift"
run "feh" --bg-fill --randomize --recursive ~/Pictures/Wallpapers/
run "flameshot"
run "jetbrains-toolbox"

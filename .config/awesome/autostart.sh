#!/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run "redshift"
run "feh" --bg-fill --randomize --recursive /mnt/shared-storage/Wallpapers/
run "flameshot"
run "jetbrains-toolbox"

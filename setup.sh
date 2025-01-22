#!/usr/bin/zsh

./install-deps.sh

./create-symlinks.sh

sudo systemctl enable bluetooth.service

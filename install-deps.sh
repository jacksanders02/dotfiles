#!/usr/bin/zsh

sudo pacman -S - < packages.txt
yay -S - < packages-aur.txt

flatpak install vesktop

sudo npm install --global pure-prompt

pulseaudio --start

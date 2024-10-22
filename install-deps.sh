#!/usr/bin/zsh

sudo pacman -S - < packages.txt
yay -S - < packages-aur.txt

flatpak install vesktop

# Install rvm
curl -sSL https://get.rvm.io | bash

# Install fnm
curl -fsSL https://fnm.vercel.app/install | bash

sudo npm install --global pure-prompt

pulseaudio --start

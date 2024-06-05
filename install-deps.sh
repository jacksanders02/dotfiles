#!/usr/bin/zsh

# Install dependencies
sudo pacman -S xorg-server xorg-xinit xterm xclip flameshot kitty neofetch ranger feh arandr redshift spotify-launcher firefox-developer-edition zoxide pulseaudio pamixer nodejs npm python acpid xdotool rofimoji noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra rofi jre-openjdk zip unzip inkscape openssh dolphin qt6ct kvantum adwaita-icon-theme hicolor-icon-theme kdegraphics-thumbnailers kimageformats libheif qt6-imageformats kdesdk-thumbnailers ffmpegthumbs taglib

yay -S awesome-git git-quick-stats spicetify-cli jetbrains-toolbox light neovim-symlinks simplescreenrecorder nm-applet resvg raw-thumbnailer kde-thumbnailer-apk

sudo npm install --global pure-prompt

sudo systemctl enable acpid.service

pulseaudio --start

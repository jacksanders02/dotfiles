#!/usr/bin/zsh

system_files=(
    'etc/udev/rules.d'
    'etc/X11/xorg.conf.d'
    'usr/local/bin/monitor_autoconnect.sh'
)

user_files=(
    '.ssh/config'
    '.config/awesome'
    '.config/flameshot'
    '.config/fontconfig'
    '.config/kitty'
    '.config/neofetch'
    '.config/nvim'
    '.config/ranger'
    '.config/redshift'
    '.config/spicetify'
    '.oh-my-zsh'
    '.Xresources'
    '.zshenv'
    '.zshrc'
)

# Install dependencies
sudo pacman -S xorg-server xorg-xinit xterm flameshot kitty neofetch ranger feh arandr redshift spotify-launcher firefox-developer-edition zoxide pulseaudio pamixer nodejs npm python acpid xdotool rofimoji noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra rofi jre-openjdk zip unzip inkscape openssh

yay -S awesome-git git-quick-stats spicetify-cli jetbrains-toolbox light neovim-symlinks simplescreenrecorder nm-applet

npm install --global pure-prompt

sudo systemctl enable acpid.service

pulseaudio --start

for file in $user_files; do
    rm -r $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in $system_files; do
    sudo ln -s $HOME/dotfiles/$file /$file
done

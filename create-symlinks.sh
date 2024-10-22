#!/usr/bin/zsh

user_files=(
    '.ssh/config'
    '.config/flameshot'
    '.config/fontconfig'
    '.config/hypr'
    '.config/kitty'
    '.config/neofetch'
    '.config/nvim'
    '.config/ranger'
    '.config/rofi'
    '.config/spicetify'
    '.config/swaync'
    '.config/Thunar'
    '.config/waybar'
    '.config/wlogout'
    '.oh-my-zsh'
    '.zlogin'
    '.zshenv'
    '.zshrc'
)

root_files = (
    'etc/udev/rules.d/95-hdmi-plug.rules'
)

for file in $user_files; do
    rm -r $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in $root_files; do
    sudo rm -r /$file
    sudo ln -s $HOME/dotfiles/$file /$file
done

echo "Done! Please logout and back in again for changes to take effect."

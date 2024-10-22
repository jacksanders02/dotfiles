#!/usr/bin/zsh

required_user_directories=(
    $HOME/.ssh
    $HOME/.catppuccin
    $HOME/.config
    $HOME/Pictures/wallpapers
)

required_root_directories=(
    /etc/udev/rules.d
)

user_files=(
    '.ssh/config'
    '.catppuccin/catppuccin_frappe-zsh-syntax-highlighting.zsh'
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
    'Pictures/wallpapers/forest.jpg'
)

root_files=(
    'etc/udev/rules.d/95-hdmi-plug.rules'
)

for user_directory in $required_user_directories; do
    mkdir -p $user_directory
done

for root_directory in $required_root_directories; do
    sudo mkdir -p $root_directory
done

for file in $user_files; do
    rm -r $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in $root_files; do
    sudo rm -r /$file
    sudo ln -s $HOME/dotfiles/$file /$file
done

echo "Done! Please logout and back in again for changes to take effect."

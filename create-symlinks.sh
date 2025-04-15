#!/usr/bin/zsh

user_symlinks=(
    '.ssh/config'
    '.catppuccin/catppuccin_frappe-zsh-syntax-highlighting.zsh'
    '.config/flameshot'
    '.config/fontconfig'
    '.config/hypr'
    '.config/kitty'
    '.config/mpv'
    '.config/neofetch'
    '.config/nvim'
    '.config/ranger'
    '.config/rofi'
    '.config/spicetify'
    '.config/swaync'
    '.config/Thunar'
    '.config/waybar'
    '.config/wlogout'
    '.dockerfiles'
    '.scripts/colour-picker.sh'
    '.scripts/monitor-connect.sh'
    '.oh-my-zsh'
    '.zlogin'
    '.zshenv'
    '.zshrc'
    'Pictures/wallpapers/forest.jpg'
)

root_files=(
    'etc/udev/rules.d/95-hdmi-plug.rules'
    'etc/NetworkManager/conf.d/00-macrandomize.conf'
    'etc/NetworkManager/dispatcher.d/09-timezone'
)

for symlink in $user_symlinks; do
    mkdir -p "$HOME/${symlink%/*}"
    rm -r $HOME/$symlink
    ln -s $HOME/dotfiles/$symlink $HOME/$symlink
done

for symlink in $root_files; do
    sudo mkdir -p "$HOME/${symlink%/*}"
    sudo rm -r /$symlink
    sudo ln -s $HOME/dotfiles/$symlink /$symlink
done

echo "Done! Please logout and back in again for changes to take effect."

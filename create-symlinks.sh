#!/usr/bin/zsh

system_files=(
    'etc/environment'
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
    '.config/Kvantum'
    '.config/neofetch'
    '.config/nvim'
    '.config/qt6ct'
    '.config/ranger'
    '.config/redshift'
    '.config/spicetify'
    '.oh-my-zsh'
    '.xinitrx'
    '.Xresources'
    '.zlogin'
    '.zshenv'
    '.zshrc'
)

for file in $user_files; do
    rm -r $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in $system_files; do
    sudo rm -r /$file
    sudo ln -s $HOME/dotfiles/$file /$file
done

echo "Done! Please logout and back in again for changes to take effect."

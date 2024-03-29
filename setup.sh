#!/usr/bin/zsh

system_files=(
    'etc/udev/rules.d'
    'etc/X11/xorg.conf.d'
    'usr/local/bin/monitor_autoconnect.sh'
)

user_files=(
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

for file in $user_files; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in $system_files; do
    sudo ln -s $HOME/dotfiles/$file /$file
done

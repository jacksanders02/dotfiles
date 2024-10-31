pacman -Qe |cut -f 1 -d " " > packages.txt
pacman -Qm |cut -f 1 -d " " > packages-aur.txt

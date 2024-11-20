pacman -Qe |cut -f 1 -d " " > temp.txt
comm -12 <(pacman -Slq | sort) <(sort temp.txt) | tee packages.txt > /dev/null
rm temp.txt
pacman -Qm |cut -f 1 -d " " > packages-aur.txt

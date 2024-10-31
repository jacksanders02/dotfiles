colour=$(hyprpicker -n)
wl-copy $colour & notify-send -a hyprpicker -t 1500 -i colorgrab "$colour copied to clipboard!"

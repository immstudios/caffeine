#
# Settings
#

keyboard_layouts="us,cz"

#
# Desktop wallpaper
#

default_wallpaper="/usr/share/backgrounds/caffeine.png"
wallpaper_dir="$HOME/Pictures/wallpapers"
wallpaper="$HOME/.cache/current-wallpaper.png"

if [ -d $wallpaper_dir ] && ls -A $wallpaper_dir/*.png ; then
    background=`find $wallpaper_dir -type f -name *.png | shuf -n 1`
else
    background=$default_wallpaper
fi

if [ -e $wallpaper ]; then
    rm $wallpaper
fi

ln -s "$background" "$wallpaper"
feh --bg-scale --no-fehbg "$wallpaper"

#
# Everything else
#

setxkbmap -layout $keyboard_layouts -option grp:alt_shift_toggle
numlockx
compton &
touchegg &
nm-applet &
redshift &
[ ! -s ~/.config/mpd/pid ] && mpd

#
# Settings
#

keyboard_layouts="us,cz"
wallpaper="/usr/share/backgrounds/caffeine.png"
wallpaper_dir="$HOME/Pictures/wallpapers"

#
# Desktop wallpaper
#

if [ -d $wallpaper_dir ] && ls -A $wallpaper_dir/*.jpg ; then
    feh --bg-scale --no-fehbg --randomize $wallpaper_dir
else
    feh --bg-scale --no-fehbg /usr/share/backgrounds/caffeine.png
fi

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

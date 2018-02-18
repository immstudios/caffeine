#!/bin/bash

flags=""

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -w|--windows)
            flags="$flags -u"
            ;;
        *)
            # unknown option
        ;;
    esac
    shift # past argument or value
done

screenshots_dir="$HOME/Pictures/screenshots"

if [ ! -d $screenshots_dir ] && [ ! -L $screenshots_dir ]; then
    mkdir -p $screenshots_dir
fi

name="shot-$(hostname)-%Y%m%d-%H%M%S.png"
scrot $name $flags -e "mv \$f $screenshots_dir && echo -n \$f | xclip"
notify-send -u low -t 2 "Screenshot created" "$(xclip -o)"

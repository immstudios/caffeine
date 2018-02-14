#!/bin/bash

screenshots_dir="$HOME/Pictures/screenshots"

if [ ! -d $screenshots_dir ] && [ ! -L $screenshots_dir ]; then
    mkdir -p $screenshots_dir
fi

scrot '%Y-%m-%d_$wx$h.png' -e "mv \$f $screenshots_dir"

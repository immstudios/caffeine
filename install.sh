#!/bin/bash
#
# Copyright (c) 2018 imm studios, z.s.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
##############################################################################
## COMMON UTILS

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
temp_dir="/tmp/caffeine-installer"

function error_exit {
    printf "\n\033[0;31mInstallation failed\033[0m\n"
    cd ${base_dir}
    exit 1
}

function finished {
    printf "\n\033[0;92mInstallation completed\033[0m\n"
    cd ${base_dir}
    exit 0
}

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   error_exit
fi

if [ ! -d ${temp_dir} ]; then
    mkdir ${temp_dir} || error_exit
fi

## COMMON UTILS
##############################################################################


REPOS=(
    "https://github.com/Airblader/i3"
)


UBUNTU_SPECIFIC=(
    ubuntu-restricted-extras
)



function download_repos {
    cd ${temp_dir}
    for i in ${REPOS[@]}; do
        MNAME=`basename $i`
        if [ -d $MNAME ]; then
            cd $MNAME
            git pull || return 1
            cd ..
        else
            git clone $i || return 1
        fi
    done
    return 0
}


function install_apt {
    apt update || return 1

    apt install -y \
        vim git screen curl mc aptitude \
        htop nload nmap net-tools \
        build-essentials autoconf automake autogen \
        python-pip python3-pip || return 1

    apt install -y \
        numlockx xclip rxvt-unicode-256color xdotool \
        rofi compton redshift touchegg \
        zathura mpv feh scrot || return 1
}


function install_apps {
    APPS_LIST=(
       vlc
       taskwarrior
       mutt
       weechat
    )
}


function install_i3 {
    cd ${temp_dir}/i3
    if [ -d build/ ]; then
        rm -rf build/
    fi
    autoreconf -- force --install || return 1
    cd build
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers || return 1
    make || return 1
    make install || return 1

    apt install -y i3lock || return 1
}

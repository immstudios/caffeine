#!/bin/bash

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

config_dir="$HOME/.config"
caffeine_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ ! -d $config_dir ]; then
    mkdir -p $config_dir
fi

function install_root {

    # X server and audio
    apt install -y \
        xserver-xorg xdm  \
        pulseaudio pulseaudio-utils pavucontrol \
        || return 1

    # Desktop notifications
    apt install -y \
        dunst libnotify-bin dbus-x11 || return 1

    # XDM Configuration
    cp $caffeine_dir/global/etc/X11/xdm/Xresources /etc/X11/xdm/Xresources
    cp $caffeine_dir/global/etc/X11/xdm/Xsetup /etc/X11/xdm/Xsetup

    echo "exec i3" > $HOME/.xsession

}

function install_user {
    ln -s $caffeine_dir/home/.config/dunst        $config_dir/dunst
    ln -s $caffeine_dir/home/.config/scripts      $config_dir/scripts
}


if [ "$(id -u)" != "0" ]; then
    install_user || error_exit
else
    install_root || error_exit
fi

finished

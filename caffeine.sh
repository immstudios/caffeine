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
    apt install -y \
        git vim mc htop screen aptitude curl \
        nload nmap net-tools \
        python-pip python3-pip || return 1

    # X server and audio
    apt install -y \
        i3 i3lock i3status \
        numlockx xclip rxvt-unicode-256color \
        scrot feh rofi compton redshift touchegg || return 1

    pip3 install py3status python-mpd2 || return 1

    # Console based apps
    apt install -y \
        mpd mpc ncmpcpp weechat mutt w3m aview || return 1

    # Desktop apps
    apt install -y \
        zathura vlc || return 1

    # Default background
    if [ ! -d /usr/share/backgrounds ]; then
        mkdir -p /usr/share/backgrounds
    fi

    cp $caffeine_dir/global/usr/share/backgrounds/caffeine.png /usr/share/backgrounds

    # Console font
    if [ ! -d /usr/share/fonts/caffeine-font ]; then
        mkdir -p /usr/share/fonts/caffeine-font
    fi

    cp -r $caffeine_dir/global/usr/share/fonts/caffeine-font /usr/share/fonts/

    update-alternatives --set x-terminal-emulator /usr/bin/urxvt
    if [ -f /etc/mpd.conf]; then rm /etc/mpd.conf; fi
    systemctl disable mpd
}


function install_user {
    if [ ! -d $config_dir ]; then
        mkdir $config_dir;
    fi

    if [ -f $HOME/.Xresources ];        then rm $HOME/.Xresources; fi
    if [ -d $config_dir/i3 ];           then rm -rf $config_dir/i3; fi
    if [ -d $config_dir/i3status ];     then rm -rf $config_dir/i3status; fi
    if [ -d $config_dir/mpd ];          then rm -rf $config_dir/mpd; fi
    if [ -d $config_dir/mpv ];          then rm -rf $config_dir/mpv; fi
    if [ -d $config_dir/touchegg ];     then rm -rf $config_dir/touchegg; fi
    if [ -d $config_dir/scripts ];      then rm -rf $config_dir/scripts; fi

    ln -s $caffeine_dir/home/.Xresources          $HOME/.Xresources
    ln -s $caffeine_dir/home/.config/i3           $config_dir/i3
    ln -s $caffeine_dir/home/.config/i3status     $config_dir/i3status
    ln -s $caffeine_dir/home/.config/mpd          $config_dir/mpd
    ln -s $caffeine_dir/home/.config/mpv          $config_dir/mpv
    ln -s $caffeine_dir/home/.config/touchegg     $config_dir/touchegg
    ln -s $caffeine_dir/home/.config/scripts      $config_dir/scripts

}

if [ "$(id -u)" == "0" ]; then
    install_root || error_exit
fi
install_user || error_exit

finished

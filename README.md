CAFFEINE
========

Desktop environment for geeks.

Project goals
-------------

 * Minimalistic
 * Sleek
 * Keyboard only
 * Use console as much as possible
 * Still usable

Basic blocks
------------

 * i3wm - Tiling window manager
 * urxvt - Terminal emulator
 * feh - Image viewer
 * mpv - Movie player
 * mpd - Music player daemon
 * ncmpcpp - MPD Client


### Installation (easy way)

 * Install Xubuntu
 * Open terminal and enter following commands
 * `sudo apt install git`
 * `mkdir ~/Private && cd ~/Private`
 * `git clone https://github.com/immstudios/caffeine && cd caffeine`
 * `sudo ./install.sh` to download and install software
 * `./install.sh` to deploy config files
 * reboot and choose i3 session at the login screen


## Raspberry Pi


### Basic usage

#### Window management

 * Hit Mod+Enter to open new terminal window (Mod=Windows key)
 * Mod+arrow keys to switch between windows (you may use vim nav keys hjkl as well)
 * Mod+(number) to switch workspaces
 * Mod+shift+arrow keys - move window
 * Mod+T - Tabbed mode
 * Mod+S - Horizontal tiles
 * Mod+V - Vertical tiles
 * Mod+E - Swap horizontal/vertical
 * Mod+R - Resize mode

#### Tools

 * Mod+D to open application menu
 * Mod+Ctrl+L - lock desktop
 * Mod+Shift+E - logout/reboot/shutdown
 * Print Screen - Save desktop screenshot to ~/Pictures/screenshots
 * Alt+Print Screen - Save current window screenshot to ~/Pictures/screenshots


### Useful commands

 * `mp` start music player client


### Customisation

 * Put your desired desktop wallpaper(s) to `~/Pictures/wallpapers`.
   They must be the same size as your screen.



Optional blocks
---------------

Can be installed using `addons.sh` script (work in progress)

 * mutt / offlineimap / notmuch - E-mail
 * weechat - Instant messaging
 * gimp / inkscape / blender

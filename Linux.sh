#! /bin/bash

apt update

apt install vim-nox silversearcher-ag

EXTENSIONS_DIR=$HOME/.local/share/gnome-shell/extensions

# Manually install Gnome extensions:
cd $EXTENSIONS_DIR

wget https://extensions.gnome.org/download-extension/hide-dash@xenatt.github.com.shell-extension.zip?version_tag=6379

wget https://extensions.gnome.org/download-extension/hide-workspace@xenatt.github.com.shell-extension.zip?version_tag=6742

wget https://extensions.gnome.org/download-extension/icon-hider@kalnitsky.org.shell-extension.zip?version_tag=8412

wget https://extensions.gnome.org/download-extension/impatience@gfxmonk.net.shell-extension.zip?version_tag=6262

wget https://extensions.gnome.org/download-extension/Move_Clock@rmy.pobox.com.shell-extension.zip?version_tag=8468

wget https://extensions.gnome.org/download-extension/sound-output-device-chooser@kgshank.net.shell-extension.zip?version_tag=8531


# Default settings for a Debian
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

# Enable these gnome extensions
gsettings set org.gnome.shell enabled-extensions ['alternate-tab@gnome-shell-extensions.gcampax.github.com', 'TopIcons@phocean.net', 'activities-config@nls1729', 'alternative-status-menu@gnome-shell-extensions.gcampax.github.com', 'impatience@gfxmonk.net', 'Move_Clock@rmy.pobox.com', 'remove-dropdown-arrows@mpdeimos.com', 'status-area-horizontal-spacing@mathematical.coffee.gmail.com', 'gnome-shell-screenshot@ttll.de', 'brightness_control@lmedinas.org', 'EasyScreenCast@iacopodeenosee.gmail.com', 'hide-dash@xenatt.github.com']

gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface scaling-factor 2
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.GWeather distance-unit "'meters'"
gsettings set org.gnome.GWeather temperature-unit "'centigrade'"

# dash-to-dock extension
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true
gsettings set org.gnome.shell.extensions.dash-to-dock.isolate-monitors true
gsettings set org.gnome.shell.extensions.dash-to-dock.isolate-workspaces true
gsettings set org.gnome.shell.extensions.dash-to-dock.multi-monitor true
gsettings set org.gnome.shell.extensions.dash-to-dock.scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock.height-fraction 1.0

# icon-hider
gsettings set org.gnome.shell.extensions.icon-hider.hidden ['a11y', 'aggregateMenu', 'keyboard']
gsettings set org.gnome.shell.extensions.icon-hider.is-indicator-shown false

# impatience
gsettings set org.gnome.shell.extensions.net.gfxmonk.impatience.speed-factor 0.25

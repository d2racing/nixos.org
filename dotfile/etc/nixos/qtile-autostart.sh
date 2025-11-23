#!/bin/sh
# Picom compositor
picom --config ~/.config/picom/picom.conf &

# Network manager tray
nm-applet &

# Battery icon
cbatticon &

# Bluetooth applet
blueman-applet &

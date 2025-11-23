#!/bin/sh

# Pywal theme
wal -n -i ~/Pictures/wallpapers &

# Compositor
picom --experimental-backends &

# Networking tray icon for SMB browsing
nm-applet &

# File indexing helper
thunar --daemon &

# AnyDesk background services (if needed)
anydesk --service &


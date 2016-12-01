#!/bin/sh
#
# In order to have this run at login, add the following to 
# /etc/xdg/autostart/ibm-trackpoint.desktop
# 
# [Desktop Entry]
# Type=Application
# Exec=/home/andrew/start_trackpoint.sh
# Terminal=false
# Name=IBM Trackpoint
# GenericName=IBM Trackpoint
# StartupNotify=false
# Categories=System;X-Xfce-Toplevel;
#

xinput set-prop “TPPS/2 IBM TrackPoint” “Evdev Wheel Emulation” 1
xinput set-prop “TPPS/2 IBM TrackPoint” “Evdev Wheel Emulation Button” 2
xinput set-prop “TPPS/2 IBM TrackPoint” “Evdev Wheel Emulation Timeout” 200
xinput set-prop “TPPS/2 IBM TrackPoint” “Evdev Wheel Emulation Axes” 6 7 4 5

#!/bin/sh
xrandr --output eDP --mode 1920x1080 --pos 0x2160 --rotate normal --output HDMI-A-0 --off
# Restart XFCE Panels since they can get wonkey when changing monitor configurations
xfce4-panel --restart

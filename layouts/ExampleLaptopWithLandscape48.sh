#!/bin/sh
xrandr --output eDP --mode 1920x1080 --pos 0x2160 --rotate normal --output HDMI-A-0 --primary --mode 3840x2160 --pos 1920x0 --rotate normal
# Laptop on desk to left of 48" TV on stand with landscape orrientation
# 
# Move PulseAudio output to HDMI device
# https://github.com/dogue/pads must be installed into the default path for this example
pads set $(pads list | grep 'HDMI' | head -1 | cut -d[ -f2 | cut -d] -f1)

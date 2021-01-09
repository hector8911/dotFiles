#!/bin/sh

picom &
xsetroot -cursor_name left_ptr &
nitrogen --restore &
/usr/lib/notification-daemon-1.0/notification-daemon &
/home/basarov/battery.sh &
xgamma -gamma 0.8 &
exec bspwm

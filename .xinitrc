#!/bin/sh

picom &
xsetroot -cursor_name left_ptr &
nitrogen --random --set-auto &
dunst &
/home/basarov/battery.sh &
xgamma -gamma 0.8 &
exec bspwm

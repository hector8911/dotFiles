if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep startx || bspwm 
fi

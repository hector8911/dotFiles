#!/bin/bash
path="/sys/class/leds/asus::kbd_backlight/brightness"
val=$(cat "$path")
max=3
new=$(( (val + 1) % (max + 1) ))
echo "$new" > "$path"

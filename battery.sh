#!/bin/sh

while true
do
		export DISPLAY=:0.0
    battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
    ac_power=$(acpi -b|grep -c "Charging")
		if [ $battery_level = 100 ]; then
				notify-send -i "/home/basarov/Pictures/battery-full.svg" "Battery is full" "Unplug your computer"
		elif [[ $ac_power -eq 0 && $battery_level -le 20 ]]; then
				notify-send -i "/home/basarov/Pictures/battery-low.svg" "Battery is lower" "Discharging: ${battery_level}%"
    fi

    sleep 300
done

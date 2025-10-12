#!/bin/sh

last_notified=0

while true
do
    export DISPLAY=:0.0
    battery_level=$(acpi -b | grep -Po '[0-9]+(?=%)')
    ac_power=$(acpi -b | grep -c "Charging")

    if [ "$ac_power" -eq 1 ] && [ "$battery_level" -eq 100 ]; then
        notify-send -u low -i dialog-information "🔋 Batería completamente cargada"
        last_notified=0
    fi

    if [ "$ac_power" -eq 0 ] && [ "$battery_level" -le 20 ]; then
        diff=$((last_notified - battery_level))
        if [ "$diff" -ge 2 ] || [ "$last_notified" -eq 0 ]; then
            if [ "$battery_level" -le 15 ]; then
                notify-send -u critical -i dialog-warning "⚠️ Batería muy baja (${battery_level}%)"
            else
                notify-send -u normal -i dialog-warning "Batería baja (${battery_level}%)"
            fi
            last_notified=$battery_level
        fi
    fi

    sleep 300
done

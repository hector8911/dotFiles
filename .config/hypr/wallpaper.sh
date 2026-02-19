#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpapers/"
MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"


WALLPAPER_DIR="$HOME/wallpapers/"

# Obtener todos los monitores
MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

# Elegir fondo aleatorio
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Precargar una vez
hyprctl hyprpaper preload "$WALLPAPER"

# Aplicar a cada monitor
for MONITOR in $MONITORS; do
    hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"
done

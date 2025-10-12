#!/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"

# Elegir uno aleatorio
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name '*.png' -o -name '*.jpg' \) | shuf -n1)

# Crear (o actualizar) un enlace simbólico que siempre apunte a la imagen aleatoria
ln -sf "$RANDOM_WALLPAPER" ~/.config/hypr/currentLockBg.png

#!/usr/bin/env bash

mode=$(dms ipc call theme getMode)

case "$mode" in
  "light") 
  niri msg action do-screen-transition 
  dms ipc call theme dark
  ln -sf ~/.config/fuzzel/dark.ini ~/.config/fuzzel/colors.ini
  ln -sf ~/.config/hypr/config/theme/dark.conf ~/.config/hypr/config/theme.conf
  start_swaybg.lua 
  ;;
  "dark") 
  niri msg action do-screen-transition 
  dms ipc call theme light
  ln -sf ~/.config/fuzzel/light.ini ~/.config/fuzzel/colors.ini
  ln -sf ~/.config/hypr/config/theme/light.conf ~/.config/hypr/config/theme.conf
  start_swaybg.lua 
  exit 0
  ;;
esac


# if [ "$mode" = "'light'" ]; then
#   niri msg action do-screen-transition 
#   dms ipc call theme dark
#   ln -sf ~/.config/fuzzel/dark.ini ~/.config/fuzzel/colors.ini
#   ln -sf ~/.config/hypr/config/theme/dark.conf ~/.config/hypr/config/theme.conf
#   start_swaybg.lua 
#   exit 0
# else
#   niri msg action do-screen-transition 
#   dms ipc call theme light
#   ln -sf ~/.config/fuzzel/light.ini ~/.config/fuzzel/colors.ini
#   ln -sf ~/.config/hypr/config/theme/light.conf ~/.config/hypr/config/theme.conf
#   start_swaybg.lua 
#   exit 0
# fi

exit 1


# if [[ command -v gsettings ]] then;
# current_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
#
# else
#
# fi
#
# if [ "$current_scheme" = "'prefer-light'" ] || [ "$current_scheme" = "'default'" ]; then
#   niri msg action do-screen-transition 
#   gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
#   dms ipc call theme dark
#
#   ln -sf ~/.config/fuzzel/dark.ini ~/.config/fuzzel/colors.ini
#   ln -sf ~/.config/rofi/shared/theme/dark.rasi ~/.config/rofi/shared/colors.rasi
#   ln -sf ~/.config/hypr/config/theme/dark.conf ~/.config/hypr/config/theme.conf
#
#   start_swaybg.lua 
#   $HOME/.config/waybar/scripts/toggle-waybar.sh --restart
#
#   notify-send "Dark Mode" "Switched to dark mode"
#   exit 0
# else
#   niri msg action do-screen-transition 
#   gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
#   dms ipc call theme light
#
#   ln -sf ~/.config/fuzzel/light.ini ~/.config/fuzzel/colors.ini
#   ln -sf ~/.config/rofi/shared/theme/light.rasi ~/.config/rofi/shared/colors.rasi
#   ln -sf ~/.config/hypr/config/theme/light.conf ~/.config/hypr/config/theme.conf
#
#   start_swaybg.lua 
#   $HOME/.config/waybar/scripts/toggle-waybar.sh --restart
#
#   notify-send "Light Mode" "Switched to light mode"
# fi

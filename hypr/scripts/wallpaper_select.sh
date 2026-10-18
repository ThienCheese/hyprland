#!/usr/bin/env bash
set -euo pipefail

# Close an existing Rofi window, if any.
if pgrep -x rofi >/dev/null 2>&1; then
    pkill -x rofi || true
    sleep 0.1
fi

wallpaper_dir="${WALLPAPER_DIR:-$HOME/Pictures/Walls/Wallpapers}"
theme_file="${ROFI_WALLPAPER_THEME:-$HOME/.config/rofi/wallpaper.rasi}"

if [[ ! -d "$wallpaper_dir" ]]; then
    notify-send "Wallpaper" "Directory not found: $wallpaper_dir"
    exit 1
fi

if ! command -v rofi >/dev/null 2>&1; then
    notify-send "Wallpaper" "Rofi is not installed or not in PATH"
    exit 1
fi

wallpaper="$(
    find "$wallpaper_dir" -path '*/.git' -prune -o -type f \( \
        -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o \
        -iname '*.webp' -o -iname '*.gif' \
    \) -print0 |
    sort -z |
    while IFS= read -r -d '' image; do
        # The path remains the selected value; icon metadata is separate.
        printf '%s\0icon\x1f%s\n' "$image" "$image"
    done |
    rofi -dmenu -i -show-icons -p "Wallpaper" -theme "$theme_file"
)" || true

[[ -n "$wallpaper" ]] || exit 0

# Keep the current wallpaper backend from the user's script.
if command -v awww >/dev/null 2>&1; then
    awww img "$wallpaper" \
        --resize crop \
        --transition-type any \
        --transition-angle 30 \
        --transition-step 90 \
        --transition-fps 144 \
        --transition-duration 1.5

else
    notify-send "Wallpaper" "Neither awww nor swww was found"
    exit 1
fi

if command -v wallust >/dev/null 2>&1; then
    wallust run "$wallpaper" >/dev/null 2>&1 &
fi


killall -SIGUSR2 waybar 2>/dev/null || true
swaync-client -rs 2>/dev/null || true
hyprctl reload

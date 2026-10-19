#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="${WALLPAPER_DIR:-$HOME/Pictures/Walls/Wallpapers}"

if [[ ! -d "$wallpaper_dir" ]]; then
    notify-send "Random Wallpaper" "Directory not found: $wallpaper_dir"
    exit 1
fi

# Tìm tất cả ảnh và chọn ngẫu nhiên 1 ảnh bằng shuf
wallpaper="$(
    find "$wallpaper_dir" -path '*/.git' -prune -o -type f \( \
        -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o \
        -iname '*.webp' -o -iname '*.gif' \
    \) -print0 |
    shuf -z -n 1 |
    tr -d '\0'
)" || true

if [[ -z "$wallpaper" ]]; then
    notify-send "Random Wallpaper" "No images found in: $wallpaper_dir"
    exit 1
fi

# Áp dụng hình nền (hỗ trợ cả awww và swww)
if command -v awww >/dev/null 2>&1; then
    awww img "$wallpaper" \
        --resize crop \
        --transition-type any \
        --transition-angle 30 \
        --transition-step 90 \
        --transition-fps 144 \
        --transition-duration 1.5
elif command -v swww >/dev/null 2>&1; then
    swww img "$wallpaper" \
        --resize crop \
        --transition-type any \
        --transition-angle 30 \
        --transition-step 90 \
        --transition-fps 144 \
        --transition-duration 1.5
else
    notify-send "Random Wallpaper" "Neither awww nor swww was found"
    exit 1
fi

# Tạo bảng màu với wallust (chạy đồng bộ để kịp cập nhật màu trước khi reload)
if command -v wallust >/dev/null 2>&1; then
    if ! wallust run "$wallpaper" >/dev/null 2>&1; then
        notify-send "Random Wallpaper" "Wallpaper applied, but Wallust failed"
    fi
fi

# Làm mới lại giao diện Waybar, SwayNC và Hyprland
killall -SIGUSR2 waybar 2>/dev/null || true
swaync-client -rs 2>/dev/null || true
hyprctl reload >/dev/null 2>&1 || true
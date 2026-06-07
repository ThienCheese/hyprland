#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
fi

wallpapers_dir="$HOME/Pictures/wallpapers"

selected_wallpaper=$(for a in "$wallpapers_dir"/*; do
    echo -en "$(basename "${a%.*}")\0icon\x1f$a\n"
done | rofi -dmenu -p "  Chọn hình nền")

if [ -z "$selected_wallpaper" ]; then
    exit 0
fi

image_fullname_path=$(find "$wallpapers_dir" -type f -name "$selected_wallpaper.*" | head -n 1)

# =====================================================================
# 🌟 TỐI ƯU TRANSITION: Đổi sang hiệu ứng 'wipe' hoặc 'center' mượt nhất
# =====================================================================
# --transition-type:   'wipe' (quét ngang) hoặc 'center' (bung từ tâm) hoặc 'simple' là mượt và ít tốn card màn hình nhất.
# --transition-fps:    Ép swww chạy ở 60Hz hoặc 144Hz (tùy theo tần số quét màn hình máy bạn).
# --transition-angle:  Góc quét (nếu dùng wipe).
swww img "$image_fullname_path" \
    --transition-type any \
    --transition-angle 30 \
    --transition-step 90 \
    --transition-fps 144 \
    --transition-duration 1.5

# =====================================================================
# 🌟 GIẢI NGHẼN CPU: Đẩy Wallust và Effects ra chạy ngầm bằng dấu '&'
# =====================================================================
# Việc thêm " > /dev/null 2>&1 &" giúp các lệnh này chạy im lặng dưới nền,
# không bắt swww phải đứng đợi, giúp animation không bị khựng (stuttering).

$HOME/.cargo/bin/wallust run "$image_fullname_path" > /dev/null 2>&1 &

/usr/bin/matugen image "$image_fullname_path" --mode dark > /dev/null 2>&1 &

~/.config/hypr/scripts/wallpaper_effects.sh > /dev/null 2>&1 &

(
    sleep 0.5
    
    # 1. Reload Hyprland (An toàn, không sinh log ra terminal bừa bãi)
    hyprctl reload

    # 2. Khởi động lại hoàn toàn Waybar tách biệt khỏi Terminal
    # Tắt hoàn toàn tiến trình Waybar cũ đang chạy
    pkill waybar
    
    # Đợi một phần nhỏ giây để port/tiến trình cũ giải phóng hoàn toàn
    sleep 0.1 
    
    # Khởi chạy lại Waybar và ném toàn bộ đầu ra (stdout, stderr) vào "hố đen" /dev/null
    waybar > /dev/null 2>&1 &

    # 3. Reload SwayNC (nếu có dùng)
    if command -v swaync-client &> /dev/null; then
        swaync-client -rs > /dev/null 2>&1
    fi
) > /dev/null 2>&1 &

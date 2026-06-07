#!/usr/bin/env bash

# Thư mục chứa hình nền của bạn
wallpapers_dir="$HOME/Pictures/wallpapers"

# =====================================================================
# 🌟 SỬA LỖI LOGIC: Lấy thẳng 1 file ngẫu nhiên (Bỏ qua bước find thứ hai)
# =====================================================================
image_fullname_path=$(find "$wallpapers_dir" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)

# Kiểm tra nếu thư mục trống không có ảnh thì dừng lại để tránh crash swww
if [ -z "$image_fullname_path" ]; then
    echo "Không tìm thấy hình nền nào trong $wallpapers_dir"
    exit 1
fi

# =====================================================================
# 🏎️ HIỆU ỨNG CHUYỂN CẢNH MƯỢT MÀ (Ép chuẩn 144Hz theo màn hình của bạn)
# =====================================================================
# Thay 'any' bằng 'outer' hoặc 'wave' hoặc 'wipe' để hiệu ứng bung ra chuẩn nhất
swww img "$image_fullname_path" \
    --transition-type any\
    --transition-pos center \
    --transition-step 90 \
    --transition-fps 144 \
    --transition-duration 1.5

# =====================================================================
# 🌟 GIẢI NGHẼN TIẾN TRÌNH: Đẩy xử lý màu và cache ra chạy ngầm (&)
# =====================================================================
$HOME/.cargo/bin/wallust run "$image_fullname_path" > /dev/null 2>&1 &

/usr/bin/matugen image "$image_fullname_path" --mode dark  > /dev/null 2>&1 &

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

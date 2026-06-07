local mainMod = "SUPER" -- Phím Windows

-- =====================================================================
-- 1. CÁC PHÍM TẮT CƠ BẢN MỞ ỨNG DỤNG
-- =====================================================================
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(_G.myTerminal))    -- Mở Kitty
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(_G.myFileManager)) -- Mở Yazi
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(_G.myMenu))        -- Mở Menu
hl.bind(mainMod .. " + C", hl.dsp.window.close())             -- Đóng cửa sổ
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))        -- Mở Trình duyệt Firefox
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))  -- Toggle notification center
-- =====================================================================
-- 2. ĐIỀU HƯỚNG CỬA SỔ (Sử dụng hệ phím HJKL kiểu Vim)
-- =====================================================================
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Nhấn SUPER + Shift + HJKL để hoán đổi trực tiếp vị trí các ô gạch
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" })) -- Bật/Tắt cửa sổ nổi (Floating)

-- =====================================================================
--  MOUSE BINDINGS - DI CHUYỂN & RESIZE FLOATING WINDOWS
-- =====================================================================
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- =====================================================================
-- 3. CÁC PHÍM TẮT TIỆN ÍCH & SCRIPT CHUYÊN SÂU (
-- =====================================================================


-- 📸 Chụp màn hình vùng chọn (Grim + Slurp) và lưu vào thư mục Pictures
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/$(date +'%Y-%m-%d-%H%M%S_grim.png')"))

-- ⌨️ Đổi ngôn ngữ IBus im lặng + Ép switch layout để đồng bộ chữ EN/VI trên Waybar Islands
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("CURRENT=$(ibus engine); if [ \"$CURRENT\" = \"m17n:vi:telex\" ]; then ibus engine xkb:us::eng; hyprctl switchxkblayout all 0; else ibus engine m17n:vi:telex; hyprctl switchxkblayout all 1; fi"))

-- 📋 Quản lý Lịch sử sao chép (Clipboard) bằng Cliphist
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/hypr/scripts/clipboard_launcher.sh"))

--  Chọn hình nền trực quan qua Rofi và tự động đổi màu hệ thống bằng Wallust
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper_select.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper_random.sh"))
	
-- =====================================================================
-- 4. VÒNG LẶP QUẢN LÝ PHÍM TẮT CHO 10 WORKSPACE (SUPER + số từ 1-9,0)
-- =====================================================================
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- =====================================================================
-- 5. ĐIỀU CHỈNH ÂM LƯỢNG THÔNG QUA HỆ THỐNG PIPEWIRE (wpctl)
-- =====================================================================
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })



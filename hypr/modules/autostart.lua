hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
--IBus (Telex)
hl.env("XMODIFIERS", "@im=ibus")
hl.env("GTK_IM_MODULE", "ibus")
hl.env("QT_IM_MODULE", "ibus")

hl.on("hyprland.start", function () 
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")    
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    
    -- Khởi động nóng lại hai dịch vụ sau khi môi trường đã sạch bóng
    hl.exec_cmd("systemctl --user restart xdg-desktop-portal-hyprland xdg-desktop-portal")

    -- Apply windowrulev2 qua hyprctl keyword
    hl.exec_cmd("hyprctl keyword windowrulev2 'float, class:floating_wifi'")
    hl.exec_cmd("hyprctl keyword windowrulev2 'size 400 550, class:floating_wifi'")
    hl.exec_cmd("hyprctl keyword windowrulev2 'move 65% 55, class:floating_wifi'")
    hl.exec_cmd("hyprctl keyword windowrulev2 'float, class:blueman-manager'")
    hl.exec_cmd("hyprctl keyword windowrulev2 'size 450 550, class:blueman-manager'")
    hl.exec_cmd("hyprctl keyword windowrulev2 'move 70% 55, class:blueman-manager'")

    -- 2. Khởi chạy các ứng dụng giao diện khác ở phía sau
    hl.exec_cmd("waybar")
    hl.exec_cmd("ibus-daemon -drx --xim --panel=disable")
    hl.exec_cmd("swww-daemon")   
    hl.exec_cmd("swaync -c /home/cheese/.config/swaync/config.jsonc")
end)


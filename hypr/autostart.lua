-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
   hl.exec_cmd("fcitx5 -d")
   hl.exec_cmd("qs")
   hl.exec_cmd("waybar")
   hl.exec_cmd("swaync")
   hl.exec_cmd("awww-daemon &")
   hl.exec_cmd("rm -f ~/.cache/cliphist/db && wl-paste --watch cliphist store &")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("XMODIFIERS", "@im=fcitx")

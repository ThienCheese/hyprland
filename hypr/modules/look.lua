local wallust_colors = require("wallust.colors")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
	    active_border   = { colors = { wallust_colors.color1, wallust_colors.color2 }, angle = 45 },
            inactive_border = wallust_colors.background,
        },
        -- Cho phép resize cửa sổ bằng cách kéo trên border/gaps
        resize_on_border = true,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 0.9,
        -- Thêm shadow cho cửa sổ
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- =====================================================================
-- ANIMATION CURVES - Các đường cong động
-- =====================================================================
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- =====================================================================
-- ANIMATIONS - Cấu hình hoạt động
-- =====================================================================
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })

-- =====================================================================
-- LAYOUT CONFIGURATIONS - Cấu hình layout
-- =====================================================================
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

-- =====================================================================
-- WINDOW RULES - CÁC CỬA SỔ NỔI CUSTOMIZE
-- =====================================================================

-- 1. Floating WiFi (nmtui)
hl.window_rule({
    name  = "floating-wifi",
    match = { class = "floating_wifi" },
    float = true,
    size  = { 420, 600 },
    move  = { "100% - 430", "44" },  -- Top right corner, below waybar
})

-- 2. Bluetooth Manager (blueman-manager)
hl.window_rule({
    name  = "floating-bluetooth",
    match = { class = "blueman-manager" },
    float = true,
    size  = { 450, 600 },
    move  = { "100% - 460", "44" },  -- Top right corner, below waybar
})

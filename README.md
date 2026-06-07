# 🌌 Cheese's Fedora Hyprland Dotfiles

<div align="center">
  <img src="https://img.shields.io/badge/OS-Fedora%20Linux-blue?style=for-the-badge&logo=fedora&logoColor=white" alt="Fedora">
  <img src="https://img.shields.io/badge/WM-Hyprland-26afe6?style=for-the-badge&logo=hyprland&logoColor=white" alt="Hyprland">
  <img src="https://img.shields.io/badge/Shell-Fish%20Shell-red?style=for-the-badge&logo=fish&logoColor=white" alt="Fish">
  <img src="https://img.shields.io/badge/Theme-Wallust%20Dynamic-orange?style=for-the-badge&logo=linux&logoColor=white" alt="Wallust">
</div>

---

A modern, fluid, and fully dynamic **Hyprland ecosystem** built on top of **Fedora Linux**. Powered by the latest **Hyprland Lua configuration framework**, featuring dynamic color-scheming via **Wallust**, seamless screen sharing, and a polished GNOME-like notification workflow.

---

## Video Showcase

<div align="center">
  <a href="https://youtu.be/6g4ZrjYYFNU" target="_blank">
    <img src="demo/2026-06-07-161634_grim.png" width="85%" alt="Watch Video Demo" style="border-radius: 8px; border: 2px solid #26afe6;"/>
    <br/>
    <b>▶ Click here to watch</b>
  </a>
</div>

<br/>

## Screenshots

<div align="center">

  <img src="demo/2026-06-07-161634_grim.png" width="90%" alt="Clean Workspace Preview" />
  <img src="demo/2026-06-07-161922_grim.png" width="90%" alt="Active Windows Preview" />
  <img src="demo/2026-06-07-161934_grim.png" width="90%" alt="Application Launcher Preview" />
  <img src="demo/2026-06-07-162137_grim.png" width="90%" alt="Control Center Preview" />
</div>

---

## Key Features

- **Pure Lua Orchestration:** Completely migrated to the cutting-edge **Hyprland 0.55+ Lua configuration**, bidding farewell to traditional `.conf` syntax for advanced modular logic.
- **Dynamic Wallust Theming:** Palette configurations change instantly based on your wallpaper. Colors propagate fluidly to Waybar, SwayNC, and terminal profiles.
- **GNOME-like Status Popups:** WiFi (`nmtui`) and Bluetooth (`blueman-manager`) act as discrete, floating corner popups aligned directly under Waybar, bypassing intrusive fullscreen tiles.
- **Complete SwayNC Workflow:** Customized Control Center with responsive volume/brightness sliders, media player metadata integrations (MPRIS), and hard-hidden persistent scrollbars.
- **Streamlined MPD + rmpc Setup:** Custom Fish shell automation scripts (`ytmp3`) to fetch, embed rich metadata/thumbnails, index to Music database, and pipe instantly into the `rmpc` client queue.
- **Fixed PipeWire Screencast:** Implemented strict asynchronous environment boot-sequencing for `xdg-desktop-portal-hyprland`, fixing cross-application screen sharing once and for all.

---

## System Components & Architecture

| Component | Software Chosen | Purpose |
| :--- | :--- | :--- |
| **OS** | Fedora 44 | Core cutting-edge stable base |
| **Window Manager** | Hyprland (0.55+) | Fluid Wayland Compositor |
| **Status Bar** | Waybar | Highly customized styling & system monitors |
| **Notification Center** | SwayNC | Rich notification agent & control center |
| **Wallpaper Daemon** | swww | Animated background transition layer |
| **Shell Environment** | Fish Shell | Interactive, user-friendly shell engine |
| **Audio Server** | PipeWire + WirePlumber | Resilient audio layout backend |
| **Music Controller** | MPD + rmpc | Lightweight backend daemon with a Vim-like TUI client |

---
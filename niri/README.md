# Niri Configuration

A modular Niri configuration focused on readability, maintainability, and native Niri workflows.

## Philosophy

* Native-first
* Simplicity over cleverness
* Official Niri solutions first
* Modular and maintainable
* One logical responsibility per file
* Prefer organization over abstraction
* Never change behavior without a clear benefit

---

## Directory Structure

```text
~/.config/niri
├── binds/
├── configs/
├── rules/
├── scripts/
├── services/
├── startup/
├── wireguard/
├── config.kdl
└── README.md
```

| Directory    | Purpose                                     |
| ------------ | ------------------------------------------- |
| `binds/`     | Keybindings grouped by function             |
| `configs/`   | Core compositor configuration               |
| `rules/`     | Window, workspace, and layer rules          |
| `scripts/`   | Helper scripts used by the Niri environment |
| `services/`  | Hypridle and Hyprlock configuration         |
| `startup/`   | Session startup modules                     |
| `wireguard/` | WireGuard profiles used by the VPN menu     |

---

## Configuration Layout

The root `config.kdl` only loads modules.

### configs/

* Input
* Monitors
* Workspaces
* Layout
* Appearance
* Animations
* Miscellaneous

### rules/

* General
* Dialogs
* Workspaces
* Media
* Utilities

### startup/

* Applications
* Clipboard
* Wallpaper

### binds/

* Applications
* Clipboard
* Media
* Networking
* Power
* Recent Windows
* Screenshots
* Windows
* Workspaces

---

## Scripts

Scripts are organized by purpose.

```text
scripts/
├── clipboard/
├── keybind/
├── monitor/
├── network/
├── screenshot/
├── filesearch.sh
├── fix-multiviewer.sh
├── hypridle-launch
├── idle-toggle.sh
├── lock-screen
└── system-audit.sh
```

They provide:

* Clipboard history management
* Keybind extraction and cheatsheet generation
* Monitor profile switching
* DNS, Wi-Fi, Bluetooth and VPN management
* Screenshot capture
* File search
* Lock and idle helpers
* System audit collection
* MultiViewer patch helper

---

## Monitor Profiles

Monitor presets are stored in:

```text
configs/monitors-preset/
```

Current presets:

* Laptop
* TV

The active configuration is:

```text
configs/monitors.kdl
```

---

## Services

* `idle.conf` — Hypridle configuration
* `lock.conf` — Hyprlock configuration

---

## Entry Point

Everything is loaded from:

```text
config.kdl
```

The root file contains only module includes.

---

## Design Goal

Keep the configuration easy to navigate, easy to modify, and easy to maintain while using native Niri functionality wherever possible.


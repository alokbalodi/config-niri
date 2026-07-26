# Install Notes

This document records manual configuration that is not handled by the bootstrap script.

---

# SDDM

Create:

```text
/etc/sddm.conf.d/sddm.conf
```

```ini
[General]
DisplayServer=wayland

[Wayland]
SessionDir=/usr/share/wayland-sessions
```

---

# Graphics

GPU driver:

- `nvidia-open-dkms`

GPU switching:

- `envycontrol`

Changing GPU mode requires a full reboot.

---

# Desktop

The system uses **Niri** as the primary compositor.

Configuration:

```text
~/.config/niri
```

Shared scripts and resources:

```text
~/.config/shared
```

---

# Theme

GTK

```text
catppuccin-mocha-blue-standard+default
```

Qt

```text
catppuccin-mocha-blue
```

Icons

```text
Tela-circle-dark
```

Cursor

```text
Bibata-Modern-Ice
```

---

# DNS

DNS helper scripts are located in:

```text
~/.config/shared/scripts/network/
```

Review the available profiles before changing the active DNS configuration.

---

# Launchers

## Rofi

Rofi is used for:

- Application launcher
- Clipboard history
- DNS menu
- VPN menu
- Utility scripts

Several workflows depend on it.

---

# Qt Configuration

Qt applications are configured through:

- `qt5ct`
- `qt6ct`
- `Kvantum`

Do not remove these packages if consistent Qt theming is desired.

---

# Things to Remember

- Run the bootstrap script from inside the repository:

  ```bash
  cd ~/.config
  ./docs/recovery/bootstrap.sh
  ```

- `envycontrol` requires a reboot after changing GPU mode.

- Add the passwordless sudo rules for:
  - `envycontrol`
  - `resolvectl`

- `/etc/sddm.conf.d/sddm.conf` must be created manually.

- Enable required system services after installation (for example `NetworkManager`, `bluetooth`, `nftables`, `sddm`, and `tailscaled` if used).

- After enabling Tailscale, complete the initial login:

  ```bash
  sudo tailscale up
  ```

- Neovim installs plugins on first launch. Allow Lazy.nvim to finish before closing Neovim.

- Clipboard history requires the `wl-paste` daemon, which is started automatically by Niri.

- GTK4 applications require the Catppuccin GTK4 stylesheet to be installed or linked in:

  ```text
  ~/.config/gtk-4.0/
  ```

- Podman applications are restored separately using the documentation under:

  ```text
  ~/.config/docs/podman-recovery/
  ```

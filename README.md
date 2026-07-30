# Linux Configuration Repository

A modular Arch Linux configuration repository for a reproducible, maintainable, and recoverable desktop.

This repository contains the configuration, scripts, and documentation required to rebuild my Arch Linux system after a fresh installation.

---

## Philosophy

- Native-first
- Simplicity over cleverness
- Official solutions before custom workarounds
- Modular and maintainable
- One logical change at a time
- Recovery documented alongside configuration

---

## Environment

| Component | Software |
| ---------- | -------- |
| Distribution | Arch Linux |
| Compositor | Niri |
| Shell | Fish |
| Terminal | Kitty |
| Editor | Neovim |
| Status Bar | Waybar |
| Notifications | Mako |
| Launcher | Fuzzel |
| Theme | Catppuccin Mocha |
| Containers | Rootless Podman |

---

## Repository Structure

```text
~/.config
├── .gitignore
├── README.md
├── Kvantum/
├── Thunar/
├── background/
├── btop/
├── docs/
├── environment.d/
├── fetch/
├── fish/
├── fontconfig/
├── fuzzel/
├── gtk-3.0/
├── gtk-4.0/
├── keepassxc/
├── kitty/
├── mako/
├── mpv/
├── niri/
├── nvim/
├── qimgv/
├── qt5ct/
├── qt6ct/
├── rofi/
├── swayosd/
├── tmux/
├── waybar/
├── wlogout/
├── xdg-desktop-portal/
└── yazi/
```

---

## System Recovery

After installing a fresh Arch Linux system:

### 1. Install Git and OpenSSH

```bash
sudo pacman -S git openssh
```

### 2. Configure Git (optional, first-time setup)

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

### 3. Set up GitHub SSH authentication (optional)

If you plan to clone using SSH and do not already have an SSH key:

Generate a new SSH key:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

Press **Enter** to accept the default location (`~/.ssh/id_ed25519`). Optionally set a passphrase.

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add the key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Copy the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add the copied key to:

```text
GitHub → Settings → SSH and GPG keys → New SSH key
```

Verify authentication:

```bash
ssh -T git@github.com
```

Accept GitHub's host key when prompted.

### 4. Clone the repository

**HTTPS**

```bash
git clone https://github.com/alokbalodi/config ~/.config
```

**SSH**

```bash
git clone git@github.com:alokbalodi/config.git ~/.config
```

### 5. Run the bootstrap script

```bash
cd ~/.config
./docs/recovery/bootstrap.sh
```

### 6. Complete the remaining manual configuration

Follow:

```text
docs/recovery/install-notes.md
```

For the complete recovery procedure, post-install verification, and backup strategy, see:

```text
docs/recovery/recovery.md
```

---

## What's Included

- Niri configuration
- Fish configuration
- Neovim configuration
- Kitty configuration
- Waybar configuration
- GTK and Qt configuration
- Notification and launcher configuration
- Recovery documentation
- Podman recovery documentation

---

## What's Excluded

Generated files, caches, logs, browser profiles, container data, machine-specific state, and other files listed in `.gitignore`.

---

## Goal

Maintain a clean, modular, reproducible, and easily recoverable Arch Linux desktop.

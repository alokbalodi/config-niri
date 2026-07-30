# Recovery

This document describes the process for rebuilding the host system after a fresh Arch Linux installation.

It focuses on recovering the operating system, desktop environment, and configuration repository. Podman applications are documented separately under `docs/podman-recovery/`.

---

# Fresh Installation

1. Install Arch Linux.

2. Install Git.

3. Clone this repository into `~/.config`.

```bash
git clone https://github.com/alokbalodi/config ~/.config
```

4. Change into the repository.

```bash
cd ~/.config
```

5. Run the bootstrap script.

```bash
./docs/recovery/bootstrap.sh
```

The bootstrap script:

- Installs official packages.
- Installs `paru` if required.
- Installs AUR packages.

6. Complete the manual steps documented in:

```text
docs/recovery/install-notes.md
```

7. Reboot.

---

# Post-Install Verification

Verify the system before considering the installation complete.

## Desktop

- SDDM starts correctly.
- Niri launches successfully.
- Waybar loads.
- Wallpaper restores.
- Notifications work.
- Clipboard history works.
- Audio and brightness OSD function correctly.

## Hardware

- Audio works.
- Microphone works.
- Wi-Fi works.
- Bluetooth works.
- Brightness controls work.
- Volume controls work.
- External displays work.

## Applications

- Kitty opens.
- Firefox launches.
- Neovim starts correctly.
- Thunar opens.
- Screenshot utilities function.
- Fuzzel menus work.

## Appearance

- GTK theme applied.
- Qt theme applied.
- Icon theme applied.
- Cursor theme applied.
- Fonts render correctly.

---

# Backup Strategy

Recovery is intentionally divided into independent layers.

| Component | Recovery Method |
| --------- | --------------- |
| Operating system | Btrfs + Snapper |
| Dotfiles | Git repository |
| Personal files | File backups / Syncthing |
| Containers | Podman recovery documentation |

Each layer can be restored independently.

---

# Snapshot Strategy

Snapper manages snapshots stored on the Btrfs filesystem.

**Mode:** Btrfs

**Purpose:** Operating system recovery

Snapper snapshots protect the operating system.

The Git repository protects configuration.

These complement one another and should both be maintained.

---

## Recommended Schedule

| Frequency | Keep | Enabled |
| --------- | ---: | :-----: |
| Monthly | 2 | Yes |
| Weekly | 2 | Yes |
| Daily | 3 | Yes |
| Hourly | 6 | No |
| Boot | 5 | No |

---

## Create a Manual Snapshot

Before major upgrades or configuration changes:

```bash
sudo snapper create --description "before <change>"
```

---

## Restore

```bash
sudo timeshift --restore
```

---

## Snapshots Cover

- Installed packages
- System configuration
- Bootloader
- Kernel
- System libraries

---

## Snapshots Do Not Cover

- Home directory (`~`) using the default configuration
- Git repository
- Browser profiles
- SSH keys
- GPG keys
- Password databases
- Podman application data
- User files outside the operating system

These should be restored from their respective backups if required.

---

# Recovery Philosophy

The repository is designed so that recovery consists of rebuilding independent layers rather than restoring one monolithic backup.

1. Restore the operating system from a Snapper snapshot if required.
2. Restore the configuration repository from Git.
3. Restore personal files from backups.
4. Restore Podman applications using the documentation in `docs/podman-recovery/`.
5. Verify the system using the checklist above.

Keeping these layers independent simplifies maintenance, migration, and recovery.

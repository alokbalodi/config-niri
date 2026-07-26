#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(realpath "$SCRIPT_DIR/../..")"

if [[ "$CONFIG_DIR" != "$HOME/.config" ]]; then
  echo "Error: Repository must be located at ~/.config"
  echo "Current location: $CONFIG_DIR"
  exit 1
fi

PKGLIST="$SCRIPT_DIR/pkglist.txt"
AURLIST="$SCRIPT_DIR/aurlist.txt"

echo "[1/3] Installing official packages..."
sudo pacman -S --needed - <"$PKGLIST"

if ! command -v paru >/dev/null 2>&1; then
  echo "[2/3] paru not found. Installing paru..."

  sudo pacman -S --needed base-devel git

  git clone https://aur.archlinux.org/paru.git /tmp/paru
  (
    cd /tmp/paru
    makepkg -si
  )

  rm -rf /tmp/paru
else
  echo "[2/3] paru already installed, skipping."
fi

echo "[3/3] Installing AUR packages..."
paru -S --needed - <"$AURLIST"

echo
echo "Bootstrap complete."
echo
echo "Next steps:"
echo "  1. Review docs/recovery/install-notes.md"
echo "  2. Complete the required manual configuration"
echo "  3. Reboot"
echo "  4. Verify the Niri desktop environment"

#!/usr/bin/env bash

set -euo pipefail

# =========================
# MultiViewer Fix Script
# Arch Linux / Wayland
# =========================

APP_DIR="$HOME/Mains/apps/MultiViewer-linux-x64"
RES_DIR="$APP_DIR/resources"

echo "[0] Checking directories..."

if [[ ! -d "$APP_DIR" ]]; then
  echo "ERROR: MultiViewer directory not found:"
  echo "$APP_DIR"
  exit 1
fi

if [[ ! -d "$RES_DIR" ]]; then
  echo "ERROR: resources directory missing"
  exit 1
fi

cd "$RES_DIR"

echo "[1] Checking dependencies..."

if ! command -v node >/dev/null 2>&1; then
  echo "ERROR: nodejs not installed"
  echo "Install with:"
  echo "sudo pacman -S nodejs npm"
  exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "ERROR: npx not found"
  echo "Install with:"
  echo "sudo pacman -S npm"
  exit 1
fi

echo "[2] Restoring broken app if needed..."

if [[ ! -f app.asar ]]; then
  if [[ -f app.asar.backup ]]; then
    echo "Restoring app.asar from backup..."
    mv app.asar.backup app.asar
  else
    echo "ERROR: app.asar missing and no backup found"
    exit 1
  fi
fi

echo "[3] Cleaning previous extraction..."
rm -rf app

echo "[4] Extracting app.asar..."
npx asar extract app.asar app

echo "[5] Replacing API endpoint..."

find app -type f -exec sed -i \
  's/api\.multiviewer\.dev/api.multiviewer.app/g' {} +

echo "[6] Verifying patch..."

MATCHES=$(grep -R "api.multiviewer.dev" app || true)

if [[ -n "$MATCHES" ]]; then
  echo "WARNING: Some .dev references still exist"
  echo "$MATCHES"
else
  echo "Patch verification passed"
fi

echo "[7] Repacking..."

rm -f app.asar.backup
mv app.asar app.asar.backup

npx asar pack app app.asar

echo "[8] Cleanup..."
rm -rf app

echo
echo "[✓] MultiViewer patched successfully"
echo
echo "Backup saved as:"
echo "$RES_DIR/app.asar.backup"
echo
echo "Launch with:"
echo "$APP_DIR/multiviewer"

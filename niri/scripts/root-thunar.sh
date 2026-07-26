#!/bin/sh

exec pkexec env \
  DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
  XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
  WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
  DISPLAY="$DISPLAY" \
  GTK_THEME="catppuccin-mocha-blue-standard+default" \
  thunar "$HOME"

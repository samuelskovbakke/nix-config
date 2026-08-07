#!/usr/bin/env sh
set -u

LOGFILE="$HOME/.cache/niri-startup.log"
exec > "$LOGFILE" 2>&1

log() {
  printf "[%s] %s\n" "$(date +%H:%M:%S)" "$1"
}

# === CRITICAL WAITS ===

log "Waiting for Wayland socket..."
for i in $(seq 1 50); do
  [ -n "${WAYLAND_DISPLAY:-}" ] && break
  sleep 0.1
done
[ -z "${WAYLAND_DISPLAY:-}" ] && { log "ERROR: Wayland socket timeout"; exit 1; }

log "Waiting for DBus..."
for i in $(seq 1 50); do
  busctl --user status >/dev/null 2>&1 && break
  sleep 0.1
done

log "Waiting for xdg-desktop-portal..."
for i in $(seq 1 100); do
  systemctl --user is-active xdg-desktop-portal.service >/dev/null 2>&1 && break
  sleep 0.1
done

log "Waiting for Niri IPC..."
for i in $(seq 1 100); do
  niri msg version >/dev/null 2>&1 && break
  sleep 0.1
done

log "Waiting for compositor rendering to stabilize..."
# sleep 2

log "Core session ready"

# === WALLPAPER DAEMON ===

# log "Starting swww-daemon"
# swww-daemon >>$LOGFILE 2>&1 &
#
# log "Waiting for swww socket..."
# for i in $(seq 1 30); do
#   swww query >/dev/null 2>&1 && { log "swww-daemon ready"; break; }
#   sleep 0.1
# done

# === LAUNCH UI COMPONENTS ===

log "Launching UI components"
# waybar >>$LOGFILE 2>&1 &
# swaync >>$LOGFILE 2>&1 &
noctalia-shell >>$LOGFILE 2>&1 &
# systemctl --user start plasma-polkit-agent.service

log "Launching background services"
# sunsetr >>$LOGFILE 2>&1 &


# === WAIT LONGER FOR FLATPAK (needs more compositor setup) ===

log "Waiting for Flatpak portal readiness..."
sleep 2

# === LAUNCH NATIVE APPS FIRST ===
log "Launching native applications"
# openrgb --startminimized -p samuel.orp >>$LOGFILE 2>&1 &
ghostty >>$LOGFILE 2>&1 &
steam >>$LOGFILE 2>&1 &
vesktop >>$LOGFILE 2>&1 &
# discord >>$LOGFILE 2>&1 &
thunderbird >>$LOGFILE 2>&1 &

log "Launching Flatpak applications"
flatpak run app.zen_browser.zen >>$LOGFILE 2>&1 &

log "Startup complete ($(date +%H:%M:%S))"

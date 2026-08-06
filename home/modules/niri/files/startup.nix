# Shared header/footer; the actual spawn commands differ per machine
# (desktop delegates to scripts/startup.sh, laptop spawns things directly).
{hostname, ...}: let
  spawnCommands =
    {
      desktop = ''
        // spawn-sh-at-startup "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP & systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        // spawn-sh-at-startup "xrandr --output 'DP-3' --primary"
        // spawn-sh-at-startup "waybar"
        // spawn-sh-at-startup "swaync & ~/.config/hypr/UserScripts/WallpaperSelect.sh"
        // spawn-sh-at-startup "systemctl --user start plasma-polkit-agent.service"
        // spawn-sh-at-startup "sleep 3"
        // spawn-sh-at-startup "app.zen_browser.zen"
        // spawn-sh-at-startup "vesktop"
        // spawn-sh-at-startup "ghostty"
        // spawn-sh-at-startup "steam"
        // spawn-sh-at-startup "thunderbird"
        // spawn-sh-at-startup "ckb-next -b"
        // spawn-sh-at-startup "openrgb --startminimized -p samuel.orp"
        // spawn-sh-at-startup "niri msg workspace discord move-to-output \"PNP(AOC) Q27G4 1O0R3HA008126\""
        // spawn-sh-at-startup "sunsetr"

        // To run a shell command (with variables, pipes, etc.), use spawn-sh-at-startup:
        // spawn-sh-at-startup "qs -c ~/source/qs/MyAwesomeShell"

        spawn-sh-at-startup "~/.config/niri/scripts/startup.sh"
      '';
      laptop = ''
        // spawn-sh-at-startup "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP & systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        // spawn-sh-at-startup "swaync & ~/.config/hypr/UserScripts/WallpaperSelect.sh"
        // spawn-sh-at-startup "hypridle"
        spawn-sh-at-startup "app.zen_browser.zen & vesktop & ghostty"
        spawn-sh-at-startup "noctalia-shell"
        spawn-sh-at-startup "ckb-next -b"

        // To run a shell command (with variables, pipes, etc.), use spawn-sh-at-startup:
        // spawn-sh-at-startup "qs -c ~/source/qs/MyAwesomeShell"
      '';
    }
    .${hostname};
in ''
  // Add lines like this to spawn processes at startup.
  // Note that running niri as a session supports xdg-desktop-autostart,
  // which may be more convenient to use.
  // See the binds section below for more spawn examples.

  ${spawnCommands}

  hotkey-overlay {
      // Uncomment this line to disable the "Important Hotkeys" pop-up at startup.
      skip-at-startup
  }
''

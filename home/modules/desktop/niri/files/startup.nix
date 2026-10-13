# Shared header/footer; the actual spawn commands differ per machine
# (desktop delegates to scripts/startup.sh, laptop spawns things directly).
{hostname, ...}: let
  spawnCommands =
    {
      desktop = ''
        // To run a shell command (with variables, pipes, etc.), use spawn-sh-at-startup:
        // spawn-sh-at-startup "~/.config/niri/scripts/startup.sh"
        spawn-sh-at-startup "noctalia"
        spawn-sh-at-startup "ghostty"
        spawn-sh-at-startup "steam"
        spawn-sh-at-startup "vesktop"
        spawn-sh-at-startup "zen-beta"
        spawn-sh-at-startup "thunderbird"
        spawn-sh-at-startup "openrgb --startminimized"
        spawn-sh-at-startup "solaar -w=hide"
      '';
      laptop = ''
        // spawn-sh-at-startup "swaync & ~/.config/hypr/UserScripts/WallpaperSelect.sh"
        // spawn-sh-at-startup "hypridle"
        spawn-sh-at-startup "noctalia"
        spawn-sh-at-startup "zen-beta & vesktop & ghostty"
        spawn-sh-at-startup "ckb-next -b"

        // To run a shell command (with variables, pipes, etc.), use spawn-sh-at-startup:
        // spawn-sh-at-startup "qs -c ~/source/qs/MyAwesomeShell"
      '';
      worktop = ''
        spawn-sh-at-startup "noctalia"
        spawn-sh-at-startup "zen-beta & ghostty"
        spawn-sh-at-startup "thunderbird"
      '';
    }
    .${
      hostname
    };
in ''
  ${spawnCommands}

  hotkey-overlay {
      // Uncomment this line to disable the "Important Hotkeys" pop-up at startup.
      skip-at-startup
  }
''

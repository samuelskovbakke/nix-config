# Shared boilerplate window-rules (WezTerm workaround, PIP, KeePassXC,
# rounded corners, floating utility windows, pavucontrol, steam toasts) are
# identical on both machines. What differs is the per-app workspace
# assignment (desktop pins apps to specific monitors by output name; laptop
# has one screen so it doesn't bother) and desktop's extra steam-fullscreen
# rule, which laptop doesn't have.
{hostname, ...}: let
  appWorkspaceRules =
    {
      desktop = ''
        workspace "browser" {
          open-on-output "PNP(AOC) Q27G4 1O0QAHA011808"
          // open-on-output "DP-3"
        }

        workspace "discord" {
          open-on-output "PNP(AOC) Q27G4 1O0R3HA008126"
          // open-on-output "DP-1"
        }
        workspace "mail" {
          open-on-output "PNP(AOC) Q27G4 1O0R3HA008126"
          // open-on-output "DP-1"
        }

        workspace "terminal" {
          open-on-output "ASUSTek COMPUTER INC VG27A R7LMQS013977"
          // open-on-output "DP-2"
        }

        workspace "games" {
          open-on-output "PNP(AOC) Q27G4 1O0QAHA011808"
          // open-on-output "DP-3"
        }

        window-rule {
          match title="^$"
          open-floating true
        }

        window-rule {
          match app-id="app.zen_browser.zen"
          // match at-startup=true
          open-on-workspace "browser"
          // open-maximized true
          opacity 1.0
        }

        window-rule {
          match app-id="vesktop"
          match app-id="discord"
          open-on-workspace "discord"
          open-maximized true
          // match at-startup=true
          opacity 0.90
        }

        window-rule {
          match app-id="thunderbird"
          open-on-workspace "mail"
          open-maximized true
          // match at-startup=true
          // opacity 0.95
        }

        window-rule {
          match app-id="com.mitchellh.ghostty"
          // match at-startup=true
          open-on-workspace "terminal"
          opacity 0.95
        }

        window-rule {
          match app-id="steam|lutris|heroic|amethyst-mod-manager"
          // match at-startup=true
          open-on-workspace "games"
          open-maximized true
          // opacity 0.95
        }
      '';
      laptop = ''
        workspace "browser"
        workspace "discord"
        workspace "terminal"

        window-rule {
          match title="^$"
          open-floating true
        }

        window-rule {
          match app-id="app.zen_browser.zen"
          // match at-startup=true
          open-on-workspace "browser"
          // opacity 0.8
        }

        window-rule {
          match app-id="vesktop"
          open-on-workspace "discord"
          // match at-startup=true
          opacity 0.95
        }

        window-rule {
          match app-id="com.mitchellh.ghostty"
          // match at-startup=true
          open-on-workspace "terminal"
          opacity 0.95
        }

        /* window-rule {
          match app-id="steam|lutris|heroic"
          // match at-startup=true
          open-on-workspace "games"
          // opacity 0.95
        } */
      '';
    }
    .${
      hostname
    };
in ''
  // Uncomment this line to ask the clients to omit their client-side decorations if possible.
  // If the client will specifically ask for CSD, the request will be honored.
  // Additionally, clients will be informed that they are tiled, removing some client-side rounded corners.
  // This option will also fix border/focus ring drawing behind some semitransparent windows.
  // After enabling or disabling this, you need to restart the apps for this to take effect.
  prefer-no-csd

  ${appWorkspaceRules}

  /* window-rule {
    match is-active=false
    opacity 0.75
  } */

  // Window rules let you adjust behavior for individual windows.
  // Find more information on the wiki:
  // https://yalter.github.io/niri/Configuration:-Window-Rules

  window-rule {
      draw-border-with-background false
  }

  // Work around WezTerm's initial configure bug
  // by setting an empty default-column-width.
  window-rule {
      // This regular expression is intentionally made as specific as possible,
      // since this is the default config, and we want no false positives.
      // You can get away with just app-id="wezterm" if you want.
      match app-id=r#"^org\.wezfurlong\.wezterm$"#
      default-column-width {}
  }

  // Open the Firefox picture-in-picture player as floating by default.
  window-rule {
      // This app-id regular expression will work for both:
      // - host Firefox (app-id is "firefox")
      // - Flatpak Firefox (app-id is "org.mozilla.firefox")
      match app-id=r#"firefox$"# title="^Picture-in-Picture$"
      open-floating true
  }

  // Example: block out two password managers from screen capture.
  // (This example rule is commented out with a "/-" in front.)
  /-window-rule {
      match app-id=r#"^org\.keepassxc\.KeePassXC$"#
      match app-id=r#"^org\.gnome\.World\.Secrets$"#

      block-out-from "screen-capture"

      // Use this instead if you want them visible on third-party screenshot tools.
      // block-out-from "screencast"
  }

  // Example: enable rounded corners for all windows.
  // (This example rule is commented out with a "/-" in front.)
  window-rule {
      geometry-corner-radius 10
      clip-to-geometry true
  }

  // Make stuff float
  window-rule {
      match app-id=r#"^([Ss]team)$"#
      exclude title=r#"^([Ss]team)$"#
      match app-id=r#"^(gnome-disks|wihotspot(-gui)?)$"#
      match app-id=r#"^(file-roller|org\.gnome\.FileRoller)$"#
      match app-id=r#"^(nm-applet|nm-connection-editor|.blueman-manager-wrapped)$"#
      match app-id=r#"^(xdg-desktop-portal-gtk)$"#
      open-floating true
  }

  window-rule {
      match app-id=r#"^(pavucontrol|org\.pulseaudio\.pavucontrol|com\.saivert\.pwvucontrol)$"#
      open-floating true
      // 80% of the screen high.
      default-window-height { proportion 0.8; }
      // Half of the screen wide.
      default-column-width { proportion 0.5; }
  }

  window-rule {
      match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
      default-floating-position x=10 y=10 relative-to="bottom-right"
  }

  // open steam games in fullscreen
  window-rule {
      match app-id=r#"^steam_app_"#
      open-fullscreen true
      open-on-workspace "games"
  }
''

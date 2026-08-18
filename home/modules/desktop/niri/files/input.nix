# Desktop has no touchpad, so that block is commented out for it. Laptop
# wants "dk,us" as its primary xkb layout (opposite order from desktop)
# and needs the touchpad enabled.
{
  hostname,
  lib,
  ...
}: let
  isLaptop = hostname == "laptop";
  layout = "us,dk";
  touchpadCommentOpen = lib.optionalString (!isLaptop) "/* ";
  touchpadCommentClose = lib.optionalString (!isLaptop) " */";
in ''
  // Input device configuration.
  // Find the full list of options on the wiki:
  // https://yalter.github.io/niri/Configuration:-Input
  input {
      keyboard {
          xkb {
              // You can set rules, model, layout, variant and options.
              // For more information, see xkeyboard-config(7).

              // For example:
              layout "${layout}"
              // options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"
              options "ctrl:nocaps"

              // If this section is empty, niri will fetch xkb settings
              // from org.freedesktop.locale1. You can control these using
              // localectl set-x11-keymap.
          }

          // Enable numlock on startup, omitting this setting disables it.
          // numlock
          repeat-rate 50
          repeat-delay 300

      }

      // Next sections include libinput settings.
      // Omitting settings disables them, or leaves them at their default values.
      // All commented-out settings here are examples, not defaults.
      ${touchpadCommentOpen}touchpad {
          // off
          tap
          // dwt
          // dwtp
          // drag false
          // drag-lock
          natural-scroll
          // accel-speed 0.2
          // accel-profile "flat"
          // scroll-method "two-finger"
          disabled-on-external-mouse
      }${touchpadCommentClose}

      mouse {
          // off
          // natural-scroll
          // accel-speed 0.2
          // accel-profile "flat"
          // scroll-method "no-scroll"
      }

      trackpoint {
          // off
          // natural-scroll
          // accel-speed 0.2
          // accel-profile "flat"
          // scroll-method "on-button-down"
          // scroll-button 273
          // scroll-button-lock
          // middle-emulation
      }

      // Uncomment this to make the mouse warp to the center of newly focused windows.
      warp-mouse-to-focus

      // Focus windows and outputs automatically when moving the mouse into them.
      // Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
      focus-follows-mouse max-scroll-amount="0%"
      workspace-auto-back-and-forth
  }

  gestures {
      hot-corners {
          // Disables the desktop overview when mouse is top-left corner.
          off
      }
  }

  cursor {
      xcursor-theme "BreezeX-RosePine-Linux"
      xcursor-size 28 // Default 24 or 32

      hide-when-typing
      // hide-after-inactive-ms 5000
  }
''

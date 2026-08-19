# Header/comments are shared; the actual output blocks are wholesale
# per-host since desktop (3 named monitors) and laptop (built-in panel +
# occasional HDMI dock) don't have any layout in common.
{hostname, ...}: let
  outputs =
    {
      desktop = ''
        output "PNP(AOC) Q27G4 1O0R3HA008126" { // Left monitor PNP(AOC) Q27G4 1O0R3HA008126
            // Uncomment this line to disable this output.
            // off

            // Resolution and, optionally, refresh rate of the output.
            // The format is "<width>x<height>" or "<width>x<height>@<refresh rate>".
            // If the refresh rate is omitted, niri will pick the highest refresh rate
            // for the resolution.
            // If the mode is omitted altogether or is invalid, niri will pick one automatically.
            // Run `niri msg outputs` while inside a niri instance to list all outputs and their modes.
            mode "2560x1440@180.001"

            // You can use integer or fractional scale, for example use 1.5 for 150% scale.
            scale 1

            // Transform allows to rotate the output counter-clockwise, valid values are:
            // normal, 90, 180, 270, flipped, flipped-90, flipped-180 and flipped-270.
            transform "normal"

            // Position of the output in the global coordinate space.
            // This affects directional monitor actions like "focus-monitor-left", and cursor movement.
            // The cursor can only move between directly adjacent outputs.
            // Output scale and rotation has to be taken into account for positioning:
            // outputs are sized in logical, or scaled, pixels.
            // For example, a 3840×2160 output with scale 2.0 will have a logical size of 1920×1080,
            // so to put another output directly adjacent to it on the right, set its x to 1920.
            // If the position is unset or results in an overlap, the output is instead placed
            // automatically.
            position x=-2560 y=560
        }
        output "PNP(AOC) Q27G4 1O0QAHA011808" { // Middle monitor PNP(AOC) Q27G4 1O0QAHA011808
            // off
            focus-at-startup
            mode "2560x1440@180.001"

            scale 1

            transform "normal"

            position x=0 y=560
        }
        output "ASUSTek COMPUTER INC VG27A R7LMQS013977" { // Right monitor ASUSTek COMPUTER INC VG27A R7LMQS013977
            // off
            mode "2560x1440@164.999"

            scale 1

            transform "270"

            position x=2560 y=0
        }
      '';
      laptop = ''
        output "eDP-1" {
            mode "1920x1080"
            scale 1
            transform "normal"
            position x=0 y=0
        }

        output "HDMI-A-4" {
          position x=0 y=-1440
        }
      '';
      worktop = ''
        output "eDP-1" {
            mode "1920x1080"
            scale 1
            transform "normal"
            position x=0 y=0
        }
      '';
    }
    .${
      hostname
    };
in ''
  ${outputs}
''

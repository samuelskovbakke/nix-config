{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.desktop = {
    niri.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Niri desktop environment.";
    };

    hyprland.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Hyprland desktop environment.";
    };

    kde.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the KDE Plasma desktop environment.";
    };
  };

  config = mkMerge [
    # Assertion — prevent both from being enabled
    # (mkIf (config.desktop.niri.enable && config.desktop.hyprland.enable) {
    #   assertions = [
    #     {
    #       assertion = false;
    #       message = "You cannot enable both Niri and Hyprland simultaneously.";
    #     }
    #   ];
    # })

    # Common packages for any Wayland DE
    (mkIf (config.desktop.niri.enable || config.desktop.hyprland.enable) {
      xdg.portal = {
        enable = true;

        # This is the important part
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
          # xdg-desktop-portal-gnome
        ];

        config.common.default = ["gtk" "wlr"];
      };

      security.polkit.enable = true;
      security.polkit.enablePkexecWrapper = true;

      environment.systemPackages = with pkgs; [
        alacritty
      ];
    })

    # Niri config
    (mkIf config.desktop.niri.enable {
      # TODO: Remove below overlay if https://github.com/niri-wm/niri/issues/254 ever gets resolved.
      nixpkgs.overlays = [
        (final: prev: {
          niri =
            (final.symlinkJoin {
              name = "niri-${prev.niri.version}-quiet-session";
              paths = [prev.niri];
              nativeBuildInputs = [prev.makeWrapper];
              postBuild = ''
                rm $out/bin/niri-session
                cat > $out/bin/niri-session <<EOF
                #!/usr/bin/env bash
                exec ${prev.niri}/bin/niri-session "\$@" \
                  2> >(grep -Fv 'Calling import-environment without a list of variable names is deprecated.' >&2)
                EOF
                chmod +x $out/bin/niri-session
              '';
            }).overrideAttrs (_: {
              passthru = prev.niri.passthru or {};
            });
        })
      ];

      programs.niri.enable = true;
      environment.systemPackages = with pkgs; [xwayland-satellite];
    })

    # Hyprland config
    (mkIf config.desktop.hyprland.enable {
      services.xserver.enable = true;
      programs.hyprland = {
        enable = true;
        # withUWSM = true;
        xwayland.enable = true;
      };
      security.pam.services.hyprlock = {};
    })

    # KDE Plasma config
    (mkIf config.desktop.kde.enable {
      # Enable Plasma
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm = {
          enable = true;

          # To use Wayland (Experimental for SDDM)
          wayland.enable = true;
        };
        xserver.enable = true;
      };
    })
  ];
}

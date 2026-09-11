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

      environment.systemPackages = with pkgs; [
        alacritty
      ];
    })

    # Niri config
    (mkIf config.desktop.niri.enable {
      programs.niri.enable = true;
      # environment.systemPackages = with pkgs; [xwayland-satellite];
      # TODO: Remove below and re-enable the above package after fix is upstreamed
      environment.systemPackages = [
        (pkgs.xwayland-satellite.overrideAttrs (old: rec {
          version = "0.8.1";
          src = pkgs.fetchFromGitHub {
            owner = "Supreeeme";
            repo = "xwayland-satellite";
            tag = "v${version}";
            hash = "sha256-BUE41HjLIGPjq3U8VXPjf8asH8GaMI7FYdgrIHKFMXA=";
          };
          cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
            inherit src;
            name = "${old.pname}-${version}";
            hash = "sha256-16L6gsvze+m7XCJlOA1lsPNELE3D364ef2FTdkh0rVY="; # will fail with correct hash, paste it in
          };
        }))
      ];
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
      services.desktopManager.plasma6.enable = true;

      # Default display manager for Plasma
      services.displayManager.sddm = {
        enable = true;

        # To use Wayland (Experimental for SDDM)
        wayland.enable = true;
      };

      # Optionally enable xserver
      services.xserver.enable = true;
    })
  ];
}

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
          xdg-desktop-portal-gnome
        ];

        # Optional but recommended
        config.common.default = "wlr";
      };
      environment.systemPackages = with pkgs; [
        alacritty
      ];
    })

    # Niri config
    (mkIf config.desktop.niri.enable {
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

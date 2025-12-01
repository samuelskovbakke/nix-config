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
  ];
}

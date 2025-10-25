{
  config,
  lib,
  pkgs,
  inputs,
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
      nixpkgs.overlays = [inputs.niri.overlays.niri];
      programs.niri.package = pkgs.niri-unstable;
      environment.systemPackages = with pkgs; [xwayland-satellite];
      # services.xserver.enable = true;
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

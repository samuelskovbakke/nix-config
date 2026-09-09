{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop.shell;

  shells = {
    waybar = {
      env = "waybar";
      config = {
        programs.waybar.enable = true;
        environment.systemPackages = with pkgs; [
          hypridle
          hyprlock
          networkmanagerapplet
          nwg-displays
          nwg-look
          pyprland
          swaynotificationcenter
          swww
          wlogout
          wttrbar
          rofi
        ];
      };
    };

    noctalia = {
      env = "noctalia-shell";
      config = {
        nix.settings = {
          extra-substituters = ["https://noctalia.cachix.org"];
          extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
        };
        environment.systemPackages = [inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default];
      };
    };

    dms = {
      env = "dms-shell";
      config = {
        environment.systemPackages = with pkgs; [dms-shell];
      };
    };
  };
in {
  options.desktop.shell = lib.mkOption {
    type = lib.types.enum (builtins.attrNames shells);
    default = "noctalia-shell";
  };

  config = lib.mkMerge (
    # Apply only the selected shell
    (lib.mapAttrsToList (
        name: shell:
          lib.mkIf (cfg == name) shell.config
      )
      shells)
    ++ [
      {
        environment.sessionVariables = {
          NIRI_SHELL = shells.${cfg}.env;
        };
      }
    ]
  );
}

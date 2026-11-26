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
      env = "noctalia";
      config = {
        environment.systemPackages = with pkgs; [noctalia];

        nix.settings = {
          extra-substituters = ["https://noctalia.cachix.org"];
          extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
        };
        programs.luciole.enable = true;
        services.gvfs.enable = true; # Mount, trash, and other functionalities
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
  imports = [inputs.luciole.nixosModules.default];
  options.desktop.shell = lib.mkOption {
    type = lib.types.enum (builtins.attrNames shells);
    default = "noctalia";
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

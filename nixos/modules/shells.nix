{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.shell;

  shells = {
    waybar = {
      env = "waybar";
      config = {
        programs.waybar.enable = true;
      };
    };

    noctalia = {
      env = "noctalia-shell";
      config = {
        environment.systemPackages = with pkgs; [noctalia-shell];
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
  options.my.desktop.shell = lib.mkOption {
    type = lib.types.enum (builtins.attrNames shells);
    default = "waybar";
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

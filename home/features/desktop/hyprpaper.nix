{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      general = {
        preload = [ "~/nix-config/home/samuel/backgrounds/shaded.png" ];
        wallpaper = [ ", ~/nix-config/home/samuel/backgrounds/shaded.png" ];
      };
    };
  };
}

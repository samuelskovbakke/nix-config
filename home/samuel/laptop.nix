{ pkgs, ... }:
{
  imports = [
    ../common
    ../features/cli
    ../features/desktop
    ../features/coding
    ./home.nix
  ];

  features = {
    cli = {
      zsh.enable = true;
      fzf.enable = true;
    };
    desktop = {
      fonts.enable = true;
      hyprland.enable = true;
      wayland.enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      device = [
        {
          name = "keyboard";
          kb_layout = "dk";
        }
        {
          name = "elan0412:00-04f3:3162-touchpad";
          enabled = true;
        }
      ];
      monitor = [
        "eDP-1,1920x1080@144,auto,1.2"
        ",preferred,auto-up,1"
      ];
      workspace = [
        "1, monitor:eDP-1, default:true"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:HDMI-A-4"
        "7, monitor:HDMI-A-4"
        "8, monitor:HDMI-A-4"
        "9, monitor:HDMI-A-4"
        "10, monitor:HDMI-A-4"
      ];
    };
  };
}

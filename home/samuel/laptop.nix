{
  imports = [
    ../common
    ../features/cli
    ../features/desktop
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
        # {
        #   name = "mouse";
        #   sensitivity = -0.5;
        # }
      ];
      monitor = [
        #",1920x1080@144,0x0,1.10"
        ",1920x1080@144,auto,1.20"
      ];
      # workspace = [
      #   "1, monitor:DP-1, default:true"
      #   "2, monitor:DP-1"
      #   "3, monitor:DP-1"
      #   "4, monitor:DP-2"
      #   "5, monitor:DP-1"
      #   "6, monitor:DP-2"
      #   "7, monitor:DP-2"
      # ];
    };
  };
}

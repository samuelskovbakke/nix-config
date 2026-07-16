{pkgs, ...}: {
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "${import ./sddm-tokyonight-theme.nix {inherit pkgs;}}";
  # };

  environment.systemPackages = [pkgs.rose-pine-cursor];

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix"; # "doom", "matrix", "colormix"
      corner_bottom_left = null;
      hide_version_string = true;
      load = true;
      save = true;
    };
  };

  services.displayManager.sddm = {
    enable = false;
    package = pkgs.kdePackages.sddm;

    wayland.compositor = "kwin";
    wayland.enable = true;

    theme = "hyprddm";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];

    settings = {
      Theme = {
        CursorTheme = "BreezeX-RosePine-Linux";
        CursorSize = 32;
      };
    };
  };
}

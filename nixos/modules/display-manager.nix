{pkgs, ...}: {
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "${import ./sddm-tokyonight-theme.nix {inherit pkgs;}}";
  # };

  environment.systemPackages = [pkgs.rose-pine-cursor];

  services.displayManager.sddm = {
    enable = true;
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

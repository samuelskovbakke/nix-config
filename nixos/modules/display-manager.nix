{pkgs, ...}: {
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "${import ./sddm-tokyonight-theme.nix {inherit pkgs;}}";
  # };

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;

    wayland.compositor = "kwin";
    wayland.enable = true;

    settings = {
      General = {
        GreeterEnvironment = "QT_WAYLAND_FORCE_OUTPUT=DP-3";
      };
    };

    theme = "hyprddm";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];
  };
}

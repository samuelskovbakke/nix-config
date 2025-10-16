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

    theme = "hyprddm";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];
  };
}

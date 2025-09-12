{pkgs, ...}: {
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "${import ./sddm-tokyonight-theme.nix {inherit pkgs;}}";
  # };
  environment.systemPackages = [
    (pkgs.callPackage ./sddm-astronaut-theme.nix {
      # theme = "renzu";
      theme = "neon_jinx";
      # themeConfig = {
      #   General = {
      #     HeaderText = "Hi";
      #     Background = "/home/user/Desktop/wp.png";
      #     FontSize = "10.0";
      #   };
      # };
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;

    wayland.enable = true;

    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];
  };
}

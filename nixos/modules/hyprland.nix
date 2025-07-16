{...}: {
  services.xserver.enable = true; # Might need this for Xwayland

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = {};
}

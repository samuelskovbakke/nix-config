{pkgs, ...}: {
  services.hardware.openrgb = {
    package = pkgs.openrgb-with-all-plugins;
    enable = true;
    startupProfile = "samuel";
    motherboard = "amd";
  };
}

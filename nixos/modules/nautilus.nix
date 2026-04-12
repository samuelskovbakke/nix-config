{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nautilus
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
}

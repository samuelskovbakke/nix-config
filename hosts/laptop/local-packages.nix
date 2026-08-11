{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    hyprlock
  ];
}

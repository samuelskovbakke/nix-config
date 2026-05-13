{pkgs, ...}: {
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    vscode
    hyprlock
    # prusa-slicer
    # inkscape
    jetbrains.idea
    lm_sensors
    nodejs_latest
  ];
}

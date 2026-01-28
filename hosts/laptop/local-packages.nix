{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscode
    hyprlock
    # prusa-slicer
    # inkscape
    jetbrains.idea
    lm_sensors
  ];
}

{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    hyprlock
    acpi
    powertop
  ];
}

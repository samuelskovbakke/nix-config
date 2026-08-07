{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nix-prefetch-git
    typst

    # System diagnostic packages
    pciutils
    usbutils
    dmidecode
    vulkan-tools
    lm_sensors
    lshw-gui
    inxi
  ];
}

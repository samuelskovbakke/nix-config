{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Build / packaging utilities
    nix-prefetch-git

    # Hardware / system info
    pciutils
    usbutils
    dmidecode
    vulkan-tools
    lm_sensors
    lshw-gui
    inxi
    smartmontools

    # Resource / network monitoring
    iotop
    bandwhich
    ethtool
    nmap
  ];
}

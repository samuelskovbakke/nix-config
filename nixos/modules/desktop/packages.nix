{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Build / packaging utilities
    nix-prefetch-git

    # Key generation
    openssl

    # Hardware / system info
    dmidecode
    inxi
    lm_sensors
    lshw-gui
    pciutils
    sbctl
    smartmontools
    usbutils
    vulkan-tools

    # Resource / network monitoring
    bandwhich
    ethtool
    iotop
    nmap

    # IDK SteamVR
    iw
  ];
}

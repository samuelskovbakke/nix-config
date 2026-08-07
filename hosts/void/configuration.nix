{
  pkgs,
  host,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./local-packages.nix
    ./local-services.nix
    ../../nixos/modules/common
    ../../nixos/modules/server
  ];

  environment.systemPackages = [pkgs.home-manager];

  networking.hostName = host.hostname;

  system.stateVersion = host.stateVersion;

  hardware = {
    enableRedistributableFirmware = true;

    cpu.intel.updateMicrocode = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  /*
  // not needed for a headless server (no x11 or wayland)
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };
  };
  */
}

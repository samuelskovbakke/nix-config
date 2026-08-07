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
}

{
  pkgs,
  host,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
  ];

  environment.systemPackages = [pkgs.home-manager];

  networking.hostName = host.hostname;

  system.stateVersion = host.stateVersion;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };
}

{
  pkgs,
  stateVersion,
  hostname,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
    ./sddm-theme.nix
  ];

  environment.systemPackages = [pkgs.home-manager];

  networking.hostName = hostname;

  system.stateVersion = stateVersion;

  boot.kernelParams = ["pcie_port_pm=off" "pcie_aspm.policy=performance"];
}

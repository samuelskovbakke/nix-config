{
  pkgs,
  stateVersion,
  hostname,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules
    ./sddm-theme.nix
  ];

  hardware = {
    # Enables support for the laptops keyboard backlight and power-management
    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };

    tuxedo-drivers.enable = true;

    nvidia.prime = {
      sync.enable = true;

      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  environment.systemPackages = [pkgs.home-manager];
  services.upower.enable = true;

  networking.hostName = hostname;
  hardware.ckb-next.enable = true;

  system.stateVersion = stateVersion;

  # boot.kernelParams = [ "pcie_port_pm=off" "pcie_aspm.policy=performance" ];
  boot.kernelModules = ["it87"];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  gpu.nvidia.enable = true;
  # gpu.amd.enable = true;

  desktop.niri.enable = true;
  desktop.shell = "noctalia";
}

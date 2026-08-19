{
  pkgs,
  host,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./local-packages.nix
    ./sddm-theme.nix
    ../../nixos/modules/common
    ../../nixos/modules/desktop
    ../../nixos/modules/gaming
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

    ckb-next.enable = true;
  };

  environment.systemPackages = [pkgs.home-manager];
  services.upower.enable = true;

  networking.hostName = host.hostname;

  system.stateVersion = host.stateVersion;

  # boot.kernelParams = [ "pcie_port_pm=off" "pcie_aspm.policy=performance" ];
  boot = {
    kernelModules = ["it87"];
    kernelPackages = pkgs.linuxPackages_zen;
  };

  gpu.nvidia.enable = true;
  # gpu.amd.enable = true;

  desktop = {
    niri.enable = true;
    shell = "noctalia";
    displayManager.sddm.enable = true;
  };
}

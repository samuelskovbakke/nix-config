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

  environment.systemPackages = [pkgs.home-manager];

  networking.hostName = host.hostname;

  system.stateVersion = host.stateVersion;

  boot = {
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash" # "splash" is needed for plymouth to display the splash animation
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "amdgpu.gpu_recovery=1" # Enables GPU reset/recovery when the GPU hangs
      "amdgpu.lockup_timeout=10000" # Sets the timeout in milliseconds before the driver considers the GPU "locked up" and triggers recovery
    ];

    # Plymouth adds a custom splash animaiton instead of the wall of text sequence
    plymouth = {
      enable = true;
      theme = "colorful_loop";

      themePackages = with pkgs; [
        adi1090x-plymouth-themes
      ];
    };

    initrd.kernelModules = ["amdgpu"]; # Early KMS so the console/splash renders at native resolution

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

    kernelPackages = pkgs.linuxPackages_zen;
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.i2c.enable = true;

  # gpu.nvidia.enable = true;
  gpu.amd.enable = true;

  desktop = {
    shell = "noctalia";
    niri.enable = true;
    # hyprland.enable = true;
    # kde.enable = true;
  };
}

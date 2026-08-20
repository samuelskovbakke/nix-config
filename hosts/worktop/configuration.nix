{
  pkgs,
  host,
  lib,
  config,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules/common
    ../../nixos/modules/desktop
  ];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };

  environment.systemPackages = [pkgs.home-manager];

  powerManagement.powertop.enable = true;
  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = false; # conflicts with TLP
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60; # cap turbo on battery

        # Battery longevity: stop charging at 80% if you're usually plugged in at a desk.
        # Comment these out if you want full charge for travel days.
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # PCIe/USB/WiFi power saving
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        USB_AUTOSUSPEND = 1;
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        # Disable NMI watchdog, small idle-power win
        NMI_WATCHDOG = 0;
      };
    };

    /*
    libinput.enable = true;
        libinput.touchpad = {
          naturalScrolling = false;
          tapping = true;
          disableWhileTyping = true;
          middleEmulation = true; # trackpoint scroll via middle-click drag
        };
    */

    # Fingerprint reader
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
  };

  # Wire fingerprint into login/sudo/lock screen (works with any greeter/PAM stack)
  security.pam.services = {
    login.fprintAuth = true;
    ly.fprintAuth = true;
    sudo.fprintAuth = true;
    hyprlock.fprintAuth = true;
  };

  networking.hostName = host.hostname;

  system.stateVersion = host.stateVersion;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = ["thinkpad_acpi"];
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';
    kernelParams = [
      "i915.enable_guc=3"
      "i915.enable_psr=2"
      "intel_idle.max_cstate=10"
      "pcie_aspm=force"
    ];
  };

  # Unrelated to the stutter fix; uncomment only when you actually want dGPU offload
  # for CUDA/rendering. Intel stays primary display owner either way.
  # gpu.nvidia.enable = true;
  # hardware.nvidia.prime = {
  #   offload.enable = true;
  #   offload.enableOffloadCmd = true;
  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  desktop = {
    niri.enable = true;
    shell = "noctalia";
    displayManager.ly.enable = true;
  };
}

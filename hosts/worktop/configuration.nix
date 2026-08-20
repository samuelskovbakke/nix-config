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

    # Enables support for the laptops keyboard backlight and power-management
    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };

    tuxedo-drivers.enable = true;
  };

  environment.systemPackages = [pkgs.home-manager];

  services = {
    upower.enable = true;
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
        # If lsusb shows a Goodix "550a" variant instead, swap to:
        # driver = pkgs.libfprint-2-tod1-goodix-550a;
        # If it's an Elan sensor (04f3:0c4b) instead of Goodix:
        # driver = pkgs.libfprint-2-tod1-elan;
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
      "mem_sleep_default=s2idle"
      "i915.enable_psr=0" # PSR was causing stutter/choppiness on this panel
      "psmouse.synaptics_intertouch=1"
      # "pcie_aspm.policy=performance"  # uncomment as a second test if PSR fix alone isn't enough
    ];
  };

  # gpu.amd.enable = true;

  # NVIDIA Quadro offload — confirmed bus IDs via `lspci | grep -E "VGA|3D"`.
  # Unrelated to the stutter fix; uncomment only when you actually want dGPU offload
  # for CUDA/rendering. Intel stays primary display owner either way.
  # gpu.nvidia.enable = true;
  # hardware.nvidia.prime = {
  #   offload.enable = true;
  #   offload.enableOffloadCmd = true;
  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };

  desktop = {
    niri.enable = true;
    shell = "noctalia";
    displayManager.ly.enable = true;
  };
}

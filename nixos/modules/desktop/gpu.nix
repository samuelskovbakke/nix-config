{
  config,
  lib,
  ...
}: let
  cfg = config.gpu;
in {
  options.gpu = {
    nvidia.enable = lib.mkEnableOption "Enable NVIDIA GPU support";
    nvidia.cuda.enable = lib.mkEnableOption "Enable CUDA support for NVIDIA GPU";
    amd.enable = lib.mkEnableOption "Enable AMD GPU support";
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !(cfg.nvidia.enable && cfg.amd.enable);
          message = "Only one of gpu.nvidia.enable or gpu.amd.enable may be enabled at a time.";
        }
        {
          assertion = !(cfg.nvidia.cuda.enable && !cfg.nvidia.enable);
          message = "gpu.nvidia.cuda.enable requires gpu.nvidia.enable to be set.";
        }
      ];
    }
    # Common graphics settings
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    }

    # NVIDIA configuration
    (lib.mkIf cfg.nvidia.enable {
      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {
        # Modesetting is required for wayland.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        # package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    })

    # CUDA support - opt-in, separate from just having an Nvidia GPU
    (lib.mkIf cfg.nvidia.cuda.enable {
      nixpkgs.config.cudaSupport = true;
      nix.settings = {
        substituters = ["https://cuda-maintainers.cachix.org"];
        trusted-public-keys = ["cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="];
      };
    })

    # AMD configuration
    (lib.mkIf cfg.amd.enable {
      services.xserver.videoDrivers = ["amdgpu"];
      hardware.amdgpu.initrd.enable = true; # Starts gpu drivers before anything else to avoid mishaps

      services.lact.enable = true; # enables LACT an app for controlling GPUs
    })
  ];
}

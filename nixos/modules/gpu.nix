{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.gpu;
in {
  options.gpu = {
    nvidia.enable = lib.mkEnableOption "Enable NVIDIA GPU support";
    amd.enable = lib.mkEnableOption "Enable AMD GPU support";
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !(cfg.nvidia.enable && cfg.amd.enable);
          message = "Only one of gpu.nvidia.enable or gpu.amd.enable may be enabled at a time.";
        }
      ];
    }
    # Common graphics settings
    {
      hardware.graphics.enable = true;
    }

    # NVIDIA configuration
    (lib.mkIf cfg.nvidia.enable {
      services.xserver.videoDrivers = ["nvidia"];
      nixpkgs.config.cudaSupport = true;

      hardware.nvidia = {
        # Modesetting is required.
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

    # AMD configuration
    (lib.mkIf cfg.amd.enable {
      services.xserver.videoDrivers = ["amdgpu"];
      hardware.amdgpu.initrd.enable = true; # Starts gpu drivers before anything else to avoid mishaps

      # Optional OpenCL / Vulkan support
      # hardware.opengl.extraPackages = with pkgs; [
      #   amdvlk
      #   rocm-opencl-icd
      #   rocm-opencl-runtime
      # ];

      nixpkgs.config.cudaSupport = false;
    })
  ];
}

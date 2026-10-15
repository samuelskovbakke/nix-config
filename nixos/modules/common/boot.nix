{pkgs, ...}: {
  environment.systemPackages = [pkgs.sbctl];

  boot.loader.efi.canTouchEfiVariables = true;
  /*
  boot.loader.systemd-boot = {
    enable = true;
    /*
    The resolution of the console. The following values are valid:
    "0": Standard UEFI 80x25 mode
    "1": 80x50 mode, not supported by all devices
    "2": The first non-standard mode provided by the device firmware, if any
    "5": Applicable for SteamDeck where this mode represent horizontal mode
    "auto": Pick a suitable mode automatically using heuristics
    "max": Pick the highest-numbered available mode
    "keep": Keep the mode selected by firmware (the default)
    *\/
    consoleMode = "max";
  };
  */

  boot.loader.limine = {
    enable = true;
    # secureBoot.enable = true;
    extraEntries = ''
      /CachyOS (VR)
          protocol: linux
          module_path: boot():/8404cfeac82545898f8baf3a2a5483e6/linux-cachyos/initramfs#3f44e1634bde81b27a44cd017e39a2c5ebac7ddc1c51202a0d71ea28966cd34ca05fd7ecf1ab4097d58894f98ea0b2a0328a019ffac7499254247ae8f594de4c
          path: boot():/8404cfeac82545898f8baf3a2a5483e6/linux-cachyos/vmlinuz#1bb6b47389baaa91da76ecd3d3985fba06bbd102e43df0c77f6eeaf043d034d202adcf9c7b147a6b020ce74bd22d4c5598ad01c8b73cc08648acaf99b144f1e7
          cmdline: quiet nowatchdog splash rw rootflags=subvol=/@ root=UUID=c347cdfe-8a56-4ed5-80bd-ec965e4bf945
    '';
  };
}

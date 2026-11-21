{
  pkgs,
  lib,
  host,
  ...
}: {
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
    extraEntries = lib.mkIf (host.hostname == "desktop") ''
      /CachyOS (VR)
          protocol: linux
          module_path: boot():/8404cfeac82545898f8baf3a2a5483e6/linux-cachyos/initramfs
          path: boot():/8404cfeac82545898f8baf3a2a5483e6/linux-cachyos/vmlinuz
          cmdline: quiet nowatchdog splash rw rootflags=subvol=/@ root=UUID=c347cdfe-8a56-4ed5-80bd-ec965e4bf945
    '';
  };
}

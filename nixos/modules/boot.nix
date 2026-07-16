{
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # sets to max resolution at boot selector
  };
  # boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}

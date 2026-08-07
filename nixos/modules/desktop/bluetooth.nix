{
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    bluetooth.settings.General = {
      Experimental = true;
    };
    enableRedistributableFirmware = true;
    enableAllFirmware = true; # optional, I think
  };
  services.blueman.enable = true;
}

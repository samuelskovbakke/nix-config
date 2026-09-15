{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Experimental = true;
      };
    };
    enableRedistributableFirmware = true;
    enableAllFirmware = true; # optional, I think
  };
  # services.blueman.enable = true;
}

{pkgs, ...}: {
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;

    extest.enable = true; # Fixes steam controller mouse input
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

    extraPackages = with pkgs; [
      hidapi
    ];

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  /*
  programs.gamescope = {
    enable = true;
  };
  */

  hardware = {
    steam-hardware.enable = true;
    xone.enable = true;
    xpadneo.enable = true;
  };
}

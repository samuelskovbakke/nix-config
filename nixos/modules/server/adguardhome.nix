{...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true; # opens 53 (DNS) and 3000 (initial setup UI)
    # host defaults to 0.0.0.0, port 3000 for the web UI
  };

  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };
}

{
  networking = {
    networkmanager = {
      enable = true;
      # dns = "systemd-resolved";
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 3000 5900 5500 8080 53317 25565 27036 27037];
      allowedUDPPorts = [27036 10400 10401];
      allowedUDPPortRanges = [
        {
          from = 27031;
          to = 27035;
        }
      ];
    };
    # nameservers = ["1.1.1.1" "1.0.0.1"]; # Cloudflare DNS
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  # services.resolved = {
  #   enable = true;
  #   # fallbackDns = [];
  #   dnsovertls = "true";
  #   dnssec = "true";
  #   domains = ["~."];
  #   extraConfig = "Cache=yes";
  # };

  # # These options are unnecessary when managing DNS ourselves
  # networking.useDHCP = false;
  # networking.dhcpcd.enable = false;
}

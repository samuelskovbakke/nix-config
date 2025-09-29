{
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 5900];
    };
    nameservers = ["1.1.1.1" "1.0.0.1"]; # Cloudflare DNS
  };

  services.resolved = {
    enable = true;
    # fallbackDns = [];
    dnsovertls = "true";
    dnssec = "true";
    domains = ["~."];
    extraConfig = "Cache=yes";
  };

  # # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
}

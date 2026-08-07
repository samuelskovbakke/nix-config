{
  services = {
    power-profiles-daemon.enable = true;
    openssh.enable = true;
    fail2ban.enable = true; # if exposed to the internet
    fstrim.enable = true;
  };

  networking.firewall.enable = true;
}

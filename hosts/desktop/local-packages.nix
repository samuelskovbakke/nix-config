{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    samrewritten

    # Desktop specific
    openrgb-with-all-plugins

    # Minecraft
    ftb-app

    # RDP server access
    remmina

    # Used for installing mod organizer 2 for skyrim SE/AE
    p7zip
    protontricks
    zenity
  ];
}

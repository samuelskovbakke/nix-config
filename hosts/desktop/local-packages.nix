{
  pkgs,
  stable-pkgs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      android-tools

      samrewritten
      heroic
      qbittorrent

      # Desktop specific
      openrgb-with-all-plugins
      # easyeffects

      # Minecraft
      ftb-app

      # RDP server access
      remmina

      # Used for installing mod organizer 2 for skyrim SE/AE
      p7zip
      protontricks
      zenity

      gnome-disk-utility

      openvpn
    ])
    ++ (with stable-pkgs; [
      lutris
    ]);
}

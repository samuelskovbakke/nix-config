{pkgs, ...}: {
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    android-tools

    samrewritten
    heroic
    lutris

    jetbrains.idea

    # Desktop specific
    openrgb-with-all-plugins

    # Minecraft
    ftb-app
    zerotierone

    # RDP server access
    remmina

    # Used for installing mod organizer 2 for skyrim SE/AE
    p7zip
    protontricks
    zenity

    gnome-disk-utility
    kdePackages.polkit-kde-agent-1

    openvpn
  ];
}

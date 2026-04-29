{
  pkgs,
  stable-pkgs,
  ...
}: {
  programs.nix-ld.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages =
    (with pkgs; [
      android-tools

      samrewritten
      heroic

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
    ])
    ++ (with stable-pkgs; [
      lutris
      jetbrains.idea
    ]);
}

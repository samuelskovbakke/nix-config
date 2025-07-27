{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kitty
    ghostty
    neovim

    networkmanagerapplet
    waybar

    stow

    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    
    remmina

    # Used for installing mod organizer 2 for skyrim SE/AE 
    p7zip
    protontricks
    zenity
  ];
}

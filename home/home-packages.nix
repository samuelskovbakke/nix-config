{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    ffmpegthumbnailer
    font-manager
    ghostty
    kitty
    loupe
    neovide
    neovim
    networkmanagerapplet
    pavucontrol
    stow
    vesktop
    waybar

    # CLI utils
    bat
    bc
    brightnessctl
    btop
    eza
    fastfetch
    fzf
    git
    jq
    oh-my-zsh
    pay-respects # thefuck alternative
    playerctl
    ripgrep
    tldr
    unzip
    wget
    wl-clipboard
    wttrbar
    yad
    zip
    zoxide

    # Coding stuff
    python313

    # WM stuff
    kdePackages.xwaylandvideobridge
    libnotify
    rose-pine-hyprcursor
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal-hyprland

    # Other
    bemoji

    # Hyprland / Niri related
    grim
    hypridle
    libqalculate
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtsvg
    libsForQt5.qtstyleplugin-kvantum
    networkmanagerapplet
    nwg-displays
    nwg-look
    pamixer
    pyprland
    rofi
    slurp
    swaynotificationcenter
    swww
    waybar
    wlogout
  ];
}

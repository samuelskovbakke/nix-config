{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    pavucontrol
    vesktop
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xarchiver
    neovide
    font-manager
    loupe

    # Minecraft
    ftb-app
    zerotierone

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
    libnotify
    libsForQt5.xwaylandvideobridge
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    rose-pine-hyprcursor

    # Other
    bemoji

    # Desktop specific
    openrgb-with-all-plugins

    # Hyprland related
    grim
    hypridle
    libqalculate
    libsForQt5.qtstyleplugin-kvantum
    networkmanagerapplet
    nwg-displays
    nwg-look
    pamixer
    pyprland
    rofi-wayland
    slurp
    swaynotificationcenter
    swww
    waybar
    wlogout
  ];
}

{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    anki-bin
    ffmpegthumbnailer
    font-manager
    ghostty
    kitty
    localsend
    loupe
    neovide
    neovim
    networkmanagerapplet
    pavucontrol
    stow
    thunderbird
    ungoogled-chromium
    vesktop
    waybar
    xarchiver

    # CLI utils
    bat
    bc
    brightnessctl
    btop
    eza
    fastfetch
    fd
    fzf
    git
    gum
    jq
    lazygit
    oh-my-zsh
    pay-respects # thefuck alternative
    playerctl
    ripgrep
    tldr
    unzip
    usbutils
    uwsm
    wget
    wl-clipboard
    wttrbar
    yad
    zip
    zoxide

    # CLI anime stuff
    /*
    ani-cli
    ani-skip
    trackma-gtk
    */

    # Programming stuff
    python313
    jdk21

    # WM stuff
    libnotify
    rose-pine-hyprcursor
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-gnome
    # xdg-desktop-portal-hyprland

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
    sunsetr # Blue light filter
    swaynotificationcenter
    swww
    waybar
    wlogout
  ];
}

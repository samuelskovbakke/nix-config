# home/modules/desktop/packages.nix
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  home.packages = with pkgs; [
    # Desktop apps
    anki-bin
    (discord.override {withVencord = true;})
    ffmpegthumbnailer
    font-manager
    ghostty
    localsend
    loupe
    mission-center
    pavucontrol
    thunderbird
    ungoogled-chromium
    vesktop
    vlc
    xarchiver

    # CLI utils that depend on desktop/session state
    brightnessctl
    # playerctl
    quickshell
    uwsm
    wl-clipboard
    yad

    # CLI anime stuff
    ani-cli
    ani-skip

    # WM stuff
    libnotify

    # Other
    bemoji

    # Hyprland / Niri related
    grim
    libqalculate
    qt5.qtbase
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    qt5.qtsvg
    libsForQt5.qtstyleplugin-kvantum
    pamixer
    slurp
    sunsetr
  ];
}

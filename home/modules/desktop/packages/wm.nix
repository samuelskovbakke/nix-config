{pkgs, ...}: {
  home.packages = with pkgs; [
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

{pkgs, ...}: {
  home.packages = with pkgs; [
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
  ];
}

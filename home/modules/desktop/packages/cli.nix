{pkgs, ...}: {
  home.packages = with pkgs; [
    # Session-dependent CLI utils
    # bemoji
    brightnessctl
    libnotify
    # playerctl
    quickshell
    uwsm
    wl-clipboard
    yad

    # Anime stuff
    ani-cli
    ani-skip
  ];
}

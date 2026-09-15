{pkgs, ...}: {
  home.packages = with pkgs; [
    # Session-dependent CLI utils
    # bemoji
    brightnessctl
    libnotify
    ddcutil

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

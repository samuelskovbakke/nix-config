{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./wayland.nix
    ./wofi.nix
  ];

  programs.firefox.enable = true;

  home.packages = with pkgs; [
    vscode
    jetbrains.idea-ultimate
    neovide
    vesktop # Discord
    kdePackages.okular # PDF viewer

    brightnessctl # For managing screen brightness from the command line

    unrar
    unzip
    xdg-utils
    zip
    celluloid # Video player

    # kdePackages.dolphin
    kdePackages.qtwayland
    kdePackages.qtsvg

  ];

  home.sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";
    QT_QPA_PLATFORM = "wayland";
    EDITOR = "neovide";
    BROWSER = "firefox";
  };

  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
    font = { name = "Fira Code"; };
    themeFile = "spaceduck";
    settings = {
      copy_on_select = "yes";
      enable_audio_bell = false;
    };
  };
}

{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./wayland.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    firefox
    vscode
    neovide
    vesktop # Discord
    kdePackages.okular # PDF viewer

    brightnessctl # For managing screen brightness from the command line

    unrar
    unzip
    xdg-utils
    zip
    celluloid # Video player


  ];

  home.sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    NIXOS_OZONE_WL = "1";
    TERMINAL = "kitty";
    QT_QPA_PLATFORM = "wayland";
  };

  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
    font = {name = "Fira Code";};
    theme = "Dracula";
    settings = {copy_on_select = "yes";};
  };
}

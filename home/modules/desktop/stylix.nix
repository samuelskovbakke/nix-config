{pkgs, ...}: {
  stylix = {
    enable = true;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Catppuccin Mocha ships with mauve as its accent by default;
    # override the accent-carrying slots to Sky (#89dceb) instead.
    override = {
      base0D = "89dceb"; # blue slot -> sky (primary accent: window borders, links, etc.)
      base0E = "89dceb"; # mauve slot -> sky (secondary accent: keywords, etc.)
    };

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes = {
        applications = 10;
        terminal = 13;
        desktop = 10;
        popups = 10;
      };
    };

    icons = {
      enable = true;
      package = pkgs.flat-remix-icon-theme;
      dark = "Flat-Remix-Blue-Dark";
      light = "Flat-Remix-Blue-Light";
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };

    # Targets
    targets = {
      # Shell
      noctalia-shell.enable = true;
      noctalia.enable = true;

      # Terminal
      bat.enable = true;
      btop.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ghostty.enable = true;
      lazygit.enable = true;
      nvf.enable = true;
      tmux.enable = true;
      yazi.enable = true;

      # GTK/Qt app theming (file pickers, GIMP-style apps, etc.)
      gtk.enable = true;
      qt = {
        enable = true;
        platform = "qtct"; # or "gtk3", compare after rebuild
      };

      # Browser
      zen-browser = {
        enable = true;
        profileNames = ["default"];
      };

      # Apps
      vesktop.enable = true;
    };
  };
}

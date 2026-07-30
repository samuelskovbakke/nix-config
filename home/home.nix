{
  homeStateVersion,
  user,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./modules
    ./home-packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  news.display = "silent";

  home.pointerCursor = {
    enable = true;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 32;
    gtk.enable = true; # sets it for GTK apps
    x11.enable = true; # sets it for X11 apps (good fallback)
    hyprcursor.enable = false; # not needed for Niri
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Standard-Sky-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["sky"];
        size = "standard";
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-icon-theme;
    };

    font = {
      name = "Noto Sans";
      size = 10;
    };

    # keep legacy behavior: GTK4 uses the same theme as GTK3
    gtk4.theme = config.gtk.theme;

    # force dark preference for apps reading the old flag
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3"; # makes Qt apps pull colors from your GTK theme
    style.name = "adwaita-dark"; # fallback Qt widget style
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      monospace-font-name = "Hack 10";
      color-scheme = "prefer-dark";
    };
  };
}

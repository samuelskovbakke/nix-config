{
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
    enable = true;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = false;
  };

  home.packages = with pkgs; [
    (catppuccin-gtk.override {
      accents = ["sky"];
      size = "standard";
      variant = "mocha";
    })
  ];

  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-mocha-sky-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = ["sky"];
        size = "standard";
        variant = "mocha";
      };
    };

    colorScheme = "dark";

    iconTheme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-icon-theme;
    };

    font = {
      name = "Noto Sans";
      size = 10;
    };

    gtk4.theme = config.gtk.theme;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "kvantum";
  };
}

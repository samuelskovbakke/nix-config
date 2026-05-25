{
  homeStateVersion,
  user,
  pkgs,
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
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 32;
    gtk.enable = true; # sets it for GTK apps
    x11.enable = true; # sets it for X11 apps (good fallback)
    hyprcursor.enable = false; # not needed for Niri
  };
}

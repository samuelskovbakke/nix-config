{config, ...}: let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    fastfetch = "fastfetch";
    ghostty = "ghostty";
    "gtk-2.0" = "gtk-2.0";
    "gtk-3.0" = "gtk-3.0";
    "gtk-4.0" = "gtk-4.0";
    hypr = "hypr";
    kitty = "kitty";
    Kvantum = "Kvantum";
    OpenRGB = "OpenRGB";
    qt6ct = "qt6ct";
    rofi = "rofi";
    swaync = "swaync";
    wallust = "wallust";
    waybar = "waybar";
    wlogout = "wlogout";
  };
in {
  xdg.configFile =
    builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
  home.file.".icons".source = ~/dotfiles/.icons;
  home.file.".my-aliases.zsh".source = ~/dotfiles/.my-aliases.zsh;
  home.file.".oh-my-zsh".source = ~/dotfiles/.oh-my-zsh;
  home.file.".p10k.zsh".source = ~/dotfiles/.p10k.zsh;
  home.file."Pictures".source = ~/dotfiles/Pictures;
  home.file.".themes".source = ~/dotfiles/.themes;
  home.file.".tmux.conf".source = ~/dotfiles/.tmux.conf;
  home.file.".zsh_plugins.txt".source = ~/dotfiles/.zsh_plugins.txt;
  home.file.".zshrc".source = ~/dotfiles/.zshrc;
}

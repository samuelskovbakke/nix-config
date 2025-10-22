{
  config,
  lib,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/dotfiles";

  # Everything inside ~/.config
  configsc = [
    "Kvantum"
    "OpenRGB"
    "fastfetch"
    "ghostty"
    "gtk-2.0"
    "gtk-3.0"
    "gtk-4.0"
    "hypr"
    "kitty"
    "niri"
    "qt6ct"
    "rofi"
    "swaync"
    "wallust"
    "waybar"
    "wlogout"
  ];

  # Everything at $HOME level
  configs = [
    ".icons"
    ".my-aliases.zsh"
    ".oh-my-zsh"
    ".p10k.zsh"
    "Pictures"
    ".themes"
    ".tmux.conf"
    ".zsh_plugins.txt"
    ".zshrc"
  ];

  # build ln -s commands
  mkLinks = files: targetDir:
    builtins.concatStringsSep "\n" (map (
        f: ''ln -sfnT "${dotfiles}/${targetDir}${f}" "$HOME/${targetDir}${f}"''
      )
      files);
in {
  # Activation script: runs after Home-Manager has created $HOME
  home.activation.linkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Ensure .config exists
    mkdir -p "$HOME/.config"

    # Link home-level files
    ${mkLinks configs ""}

    # Link .config files
    ${mkLinks configsc ".config/"}
  '';
}

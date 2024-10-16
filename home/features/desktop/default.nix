{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./wayland.nix
  ];

  home.packages = with pkgs; [
  ];
}

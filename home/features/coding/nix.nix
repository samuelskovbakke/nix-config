{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
    # nix-prefetch-git
  ];
}
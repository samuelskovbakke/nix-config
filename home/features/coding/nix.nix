{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
    nil
    nixpkgs-fmt
    nix-prefetch-git
  ];
}
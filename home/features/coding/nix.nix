{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
    nixpkgs-fmt
    # nix-prefetch-git
  ];
}
{ pkgs, ... }:
{
  programs.file-roller.enable = true;
  environment.systemPackages = with pkgs; [
    nix-prefetch-git
  ];
}

{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nix-prefetch-git
    typst
  ];
}

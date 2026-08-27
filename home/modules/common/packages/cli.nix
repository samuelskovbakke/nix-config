{pkgs, ...}: {
  home.packages = with pkgs; [
    bc
    eza
    fd
    fetch # actively contributing; will replace fastfetch once mature
    git
    gum
    jq
    lazygit
    lsof
    most
    ncdu
    pay-respects
    ripgrep
    tldr
    tree
    unzip
    wget
    wol
    zip
    zoxide
  ];
  programs.btop.enable = true;
  programs.bat.enable = true;
}

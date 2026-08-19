{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    bc
    btop
    eza
    fd
    fetch # actively contributing; will replace fastfetch once mature
    fzf
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
    yazi
    zip
    zoxide
  ];
}

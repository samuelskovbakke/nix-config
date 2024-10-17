{ pkgs, ... }: {
  imports = [
    ./nix.nix
    ./tools.nix
  ];

  home.packages = with pkgs; [
    cmake
    gcc
    cargo
    python3
    jdk8
    # nodejs
  ];
}
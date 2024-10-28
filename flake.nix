{
  description = "Samuel's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    stylix.url = "github:danth/stylix";

  };

  outputs =
    { self
    , # disko,
      home-manager
    , nixpkgs
    , catppuccin
    , stylix
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/laptop
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
            # inputs.disko.nixosModules.disko
          ];
        };
      };
      homeConfigurations = {
        home-manager.backupFileExtension = "hm-bak";
        "samuel@laptop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/samuel/laptop.nix
            catppuccin.homeManagerModules.catppuccin
            stylix.homeManagerModules.stylix
          ];
        };
      };
    };

}

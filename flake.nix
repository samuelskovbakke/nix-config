{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    homeStateVersion = "24.11";
    user = "samuel";
    hosts = [
      {
        hostname = "desktop";
        stateVersion = "24.11";
      }
      {
        hostname = "laptop";
        stateVersion = "25.05";
      }
    ];
    stable-pkgs = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    makeSystem = {
      hostname,
      stateVersion,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs stateVersion hostname user stable-pkgs;
        };

        modules = [
          ./hosts/${hostname}/configuration.nix
        ];
      };
  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs
      // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {}
    hosts;

    home-manager.backupFileExtension = "backup";
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user stable-pkgs;
      };

      modules = [
        inputs.nvf.homeManagerModules.default
        inputs.nix-index-database.homeModules.nix-index
        ./home/home.nix
      ];
    };
  };
}

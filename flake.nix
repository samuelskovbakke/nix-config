{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

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

    millennium.url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    user = "samuel";
    hosts = [
      {
        hostname = "desktop";
        stateVersion = "24.11";
        isMultiMonitor = true;
        xRes = "2560";
        yRes = "1440";
      }
      {
        hostname = "laptop";
        stateVersion = "25.05";
        isMultiMonitor = false;
        xRes = "2560";
        yRes = "1440";
      }
      {
        # Server
        hostname = "void";
        stateVersion = "26.05";
        isMultiMonitor = false;
        xRes = "2560";
        yRes = "1440";
      }
    ];
    stable-pkgs = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    makeSystem = host:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs user stable-pkgs host;
          homeStateVersion = host.stateVersion;
        };
        modules = [
          {nixpkgs.overlays = [inputs.millennium.overlays.default];}
          ./hosts/${host.hostname}/configuration.nix
        ];
      };
  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs
      // {
        "${host.hostname}" = makeSystem host;
      }) {}
    hosts;
  };
}

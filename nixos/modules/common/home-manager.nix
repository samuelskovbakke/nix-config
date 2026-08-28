{
  inputs,
  user,
  stable-pkgs,
  homeStateVersion,
  host,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    sharedModules = [
      inputs.stylix.homeModules.stylix
      inputs.nvf.homeManagerModules.default
      inputs.nix-index-database.homeModules.nix-index
    ];
    extraSpecialArgs = {
      inherit inputs stable-pkgs homeStateVersion user host;
    };
    users.${user} = {
      imports = [../../../home/home.nix];
    };
  };
}

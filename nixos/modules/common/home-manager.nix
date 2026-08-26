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
    sharedModules = [inputs.stylix.homeModules.stylix];
    extraSpecialArgs = {
      inherit inputs stable-pkgs homeStateVersion user host;
    };
    users.${user} = {
      imports = [
        inputs.nvf.homeManagerModules.default
        inputs.nix-index-database.homeModules.nix-index
        ../../../home/home.nix
      ];
    };
  };
}

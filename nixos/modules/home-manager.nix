{
  inputs,
  user,
  stable-pkgs,
  homeStateVersion,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs stable-pkgs homeStateVersion user;
    };
    users.${user} = {
      imports = [
        inputs.nvf.homeManagerModules.default
        inputs.nix-index-database.homeModules.nix-index
        ../../home/home.nix
      ];
    };
  };
}

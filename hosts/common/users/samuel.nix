{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.samuel = {
    isNormalUser = true;
    description = "Samuel";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.samuel =
    import ../../../home/samuel/${config.networking.hostName}.nix;
}

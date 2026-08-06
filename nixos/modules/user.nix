{
  pkgs,
  user,
  ...
}: {
  # programs.zsh.enable = true;
  programs.fish.enable = true;

  users = {
    # defaultUserShell = pkgs.zsh;
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker" "dialout" "bluetooth" "input" "adbusers" "vboxusers"];
    };
  };

  # services.getty.autologinUser = user;
}

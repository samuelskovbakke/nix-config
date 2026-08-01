{
  pkgs,
  user,
  ...
}: {
  # programs.zsh.enable = true;
  programs.fish.enable = true;

  programs.fish.interactiveShellInit = ''
  if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update
  end
'';

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

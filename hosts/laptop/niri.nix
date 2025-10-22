{pkgs, ...}: {
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [alacritty fuzzel swaylock mako swayidle];
}

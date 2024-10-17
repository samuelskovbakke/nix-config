{
  pkgs,
  outputs,
  ...
}: {
  home.packages = with pkgs; [
    wofi 
    bemoji
  ];
}
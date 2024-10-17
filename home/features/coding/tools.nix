{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [ 
    pandoc 
    # zed-editor # maybe use this editor, looks cool.
  ];
}
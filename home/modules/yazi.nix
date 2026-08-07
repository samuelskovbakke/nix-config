{pkgs}: {
  programs.yazi = {
    enable = true;

    flavors = {
      inherit (pkgs.yaziPlugins) tokyonight;
    };
    theme = {
      flavor = {
        dark = "tokyonight";
      };
    };
  };
}

{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.callPackage ../../nixos/modules/hyprddm.nix {
      # themes: astronaut, chainsaw_fury, cloud, cybermonk, ghost, hyprland_kath, jake_the_dog, japanese_aesthetic, neon_jinx, pixel_sakura, pixel_sakura_static, post-apocalyptic_hacker, purple_leaves, renzu, savage, starman
      theme = "hyprland_kath";
      # themeConfig = {
      #   General = {
      #     HeaderText = "Hi";
      #     Background = "/home/user/Desktop/wp.png";
      #     FontSize = "10.0";
      #   };
      # };
    })
  ];
}

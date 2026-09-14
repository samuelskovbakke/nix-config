{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    # Old config had `shell-integration = zsh`, which looks like a leftover
    # from before you switched to fish -- dropped in favor of
    # enableFishIntegration above, which wires up the right shell for you.
    settings = {
      cursor-style = "bar";

      font-family = "FiraCode Nerd Font Mono";
      font-style = "Medium";
      font-size = 12;

      background-opacity = 0.7;
      background-blur = true;
    };
  };
}

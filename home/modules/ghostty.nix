{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    # Old config had `shell-integration = zsh`, which looks like a leftover
    # from before you switched to fish -- dropped in favor of
    # enableFishIntegration above, which wires up the right shell for you.
    settings = {
      theme = "noctalia";
      cursor-style = "bar";

      font-family = "FiraCode Nerd Font Mono";
      font-style = "Medium";
      font-size = 12;

      background-opacity = 0.7;
      background-blur = true;
    };

    # Custom theme, previously at ~/.config/ghostty/themes/noctalia
    themes.noctalia = {
      palette = [
        "0=#15161e"
        "1=#f7768e"
        "2=#9ece6a"
        "3=#e0af68"
        "4=#7aa2f7"
        "5=#bb9af7"
        "6=#7dcfff"
        "7=#a9b1d6"
        "8=#414868"
        "9=#f7768e"
        "10=#9ece6a"
        "11=#e0af68"
        "12=#7aa2f7"
        "13=#bb9af7"
        "14=#7dcfff"
        "15=#c0caf5"
      ];
      background = "#1a1b26";
      foreground = "#c0caf5";
      cursor-color = "#c0caf5";
      cursor-text = "#1a1b26";
      selection-background = "#283457";
      selection-foreground = "#c0caf5";
    };
  };
}

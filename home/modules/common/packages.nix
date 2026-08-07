{
  stable-pkgs,
  pkgs,
  ...
}: {
  home.packages =
    (with pkgs; [
      # CLI utils
      bat
      bc
      btop
      claude-code
      eza
      fastfetch
      fd
      fetch
      fzf
      git
      gum
      jq
      lazygit
      pay-respects
      ripgrep
      tldr
      unzip
      usbutils
      wget
      wol
      yazi
      zip
      zoxide

      # Programming stuff
      python313
      gcc
      gnumake
    ])
    ++ (with stable-pkgs; [jdk21]);
}

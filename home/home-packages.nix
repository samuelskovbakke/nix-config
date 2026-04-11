{
  pkgs,
  stable-pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.packages =
    (with pkgs; [
      # Packages in each category are sorted alphabetically

      # Desktop apps
      anki-bin
      ffmpegthumbnailer
      font-manager
      ghostty
      kitty
      localsend
      loupe
      mission-center
      neovide
      neovim
      pavucontrol
      thunderbird
      ungoogled-chromium
      vesktop
      xarchiver

      # CLI utils
      bat
      bc
      brightnessctl
      btop
      claude-code
      eza
      fastfetch
      fd
      fzf
      git
      gum
      jq
      lazygit
      oh-my-zsh
      ollama # consider switching to ollama-cuda or ollama-vulkan for gpu acceleration
      pay-respects # thefuck alternative
      playerctl
      quickshell
      ripgrep
      tldr
      unzip
      usbutils
      uwsm
      wget
      wl-clipboard
      yad
      zip
      zoxide

      # CLI anime stuff
      ani-cli
      ani-skip

      # Programming stuff
      python313

      # WM stuff
      libnotify
      rose-pine-hyprcursor

      # Other
      bemoji

      # Hyprland / Niri related
      grim
      libqalculate
      libsForQt5.qt5.qtbase
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtsvg
      libsForQt5.qtstyleplugin-kvantum
      pamixer
      slurp
      sunsetr
    ])
    ++ (with stable-pkgs; [
      jdk21
    ]);
}

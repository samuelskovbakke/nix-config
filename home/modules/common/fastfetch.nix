{...}: {
  # Only the config actually in use is tracked here; config-compact.jsonc,
  # config-old.jsonc and config-v2.jsonc from the old dotfiles were unused
  # variants and were dropped.
  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
    "fastfetch/nixos-logo.png".source = ./fastfetch/nixos-logo.png;
  };
}

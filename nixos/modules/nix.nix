{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    auto-optimise-store = true;
    download-buffer-size = 524288000;
    experimental-features = ["nix-command" "flakes"];
  };

  nix.gc = {
    automatic = true;
    dates = "daily"; # Or daily, monthly, etc.
    options = "--delete-older-than 7d";
  };

  # system.autoUpgrade = {
  #   enable = true;
  #   allowReboot = false;
  #   flake = "git+file:///home/samuel/nix-config";
  #   flags = [
  #     "--no-write-lock-file"
  #     "--update-input"
  #     "nixpkgs"
  #   ];
  #   dates = "daily";
  # };
}

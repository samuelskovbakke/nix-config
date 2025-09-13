{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings = {
    auto-optimise-store = true;
    download-buffer-size = 524288000;
  };

  nix.gc = {
    automatic = true;
    dates = "daily"; # Or daily, monthly, etc.
    options = "--delete-older-than 7d";
  };

  environment.systemPackages = with pkgs; [
    # nix-index
  ];
}

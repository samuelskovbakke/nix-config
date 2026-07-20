{
  pkgs,
  host,
  lib,
  ...
}: {
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "${import ./sddm-tokyonight-theme.nix {inherit pkgs;}}";
  # };

  environment.systemPackages = [pkgs.rose-pine-cursor];

  # If multimonitor we add a pre exec to run fbset with our primary display resolution
  # this is so the main monitor TTY ly isn't cropped
  systemd.services.display-manager = lib.mkIf (host.isMultiMonitor or false) {
    preStart = ''
      ${pkgs.fbset}/bin/fbset -xres ${host.xRes} -yres ${host.yRes}
    '';
  };
  environment.etc."ly/blackhole.dur".source = ./blackhole.dur;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file"; # "doom", "matrix", "colormix", "dur_file"
      dur_file_path = "/etc/ly/blackhole.dur";

      bigclock = "en";
      corner_bottom_left = null;

      hide_version_string = true;

      load = true;
      save = true;

      clear_password = true;
      vi_default_mode = "insert";
      vi_mode = false;
    };
  };

  services.displayManager.sddm = {
    enable = false;
    package = pkgs.kdePackages.sddm;

    wayland.compositor = "kwin";
    wayland.enable = true;

    theme = "hyprddm";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
    ];

    settings = {
      Theme = {
        CursorTheme = "BreezeX-RosePine-Linux";
        CursorSize = 32;
      };
    };
  };
}

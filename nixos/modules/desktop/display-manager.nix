{
  config,
  pkgs,
  host,
  lib,
  ...
}: let
  cfg = config.desktop.displayManager;
in {
  options.desktop.displayManager = {
    ly.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the ly display manager.";
    };
    sddm = {
      enable = lib.mkEnableOption "SDDM display manager";
      theme = lib.mkOption {
        type = lib.types.enum ["hyprddm" "tokyonight"];
        default = "hyprddm";
        description = "Which SDDM theme to use.";
      };
    };
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = [pkgs.rose-pine-cursor];

      # Secret portal backend (see home/modules/session-services.nix for the
      # user-service side). This auto-unlocks the keyring using your login
      # password when authenticating through ly.
      services.gnome.gnome-keyring.enable = true;
      security.pam.services.ly.enableGnomeKeyring = true;

      # If multimonitor we add a pre exec to run fbset with our primary display resolution
      # this is so the main monitor TTY ly isn't cropped
      systemd.services.display-manager = lib.mkIf (host.isMultiMonitor or false) {
        preStart = ''
          ${pkgs.fbset}/bin/fbset -xres ${host.xRes} -yres ${host.yRes}
        '';
      };
    }

    # sddm being enabled always wins: forces ly off
    (lib.mkIf cfg.sddm.enable {
      desktop.displayManager.ly.enable = lib.mkForce false;
    })

    (lib.mkIf cfg.ly.enable {
      environment.etc."ly/blackhole.dur".source = ./assets/ly/blackhole.dur;
      services.displayManager.ly = {
        enable = true;
        settings = {
          animation = "dur_file"; # "doom", "matrix", "colormix", "dur_file"
          dur_file_path = "/etc/ly/blackhole.dur";

          bigclock = "en";
          corner_bottom_left = null;
          full_color = true;
          asterisk = "0x2022";
          box_title = "Welcome Samuel";

          hide_version_string = true;

          load = true;
          save = true;

          clear_password = true;
          vi_default_mode = "insert";
          vi_mode = true;
        };
      };
    })

    (lib.mkIf cfg.sddm.enable {
      services.displayManager.sddm = lib.mkMerge [
        {
          enable = true;
          package = pkgs.kdePackages.sddm;

          wayland.compositor = "kwin";
          wayland.enable = true;

          extraPackages = with pkgs; [
            kdePackages.qtmultimedia
            kdePackages.qtsvg
            kdePackages.qtvirtualkeyboard
          ];
        }

        (lib.mkIf (cfg.sddm.theme == "hyprddm") {
          theme = "hyprddm";
          settings.Theme = {
            CursorTheme = "BreezeX-RosePine-Linux";
            CursorSize = 32;
          };
        })

        (lib.mkIf (cfg.sddm.theme == "tokyonight") {
          theme = "${import ./assets/sddm/sddm-tokyonight-theme.nix {inherit pkgs;}}";
        })
      ];
    })
  ];
}

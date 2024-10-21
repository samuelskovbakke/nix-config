{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.wayland;
in
{
  options.features.desktop.wayland.enable = mkEnableOption "wayland extra tools and config";

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      style = ''
        @define-color background-darker rgba(30, 31, 41, 230);
        @define-color background #282a36;
        @define-color selection #44475a;
        @define-color foreground #f8f8f2;
        @define-color comment #6272a4;
        @define-color cyan #8be9fd;
        @define-color green #50fa7b;
        @define-color orange #ffb86c;
        @define-color pink #ff79c6;
        @define-color purple #bd93f9;
        @define-color red #ff5555;
        @define-color yellow #f1fa8c;

        * {
            border: none;
            border-radius: 0;
            font-family: FontAwesome-Free, FiraCode Nerd Font;
            font-weight: bold;
            font-size: 14px;
            min-height: 0;
        }

        window#waybar {
            background: rgba(21, 18, 27, 0);
            color: #cdd6f4;
        }

        tooltip {
            background: #1e1e2e;
            border-radius: 10px;
            border-width: 2px;
            border-style: solid;
            border-color: #11111b;
        }

        #workspaces button {
            padding: 5px;
            color: #313244;
            margin-right: 5px;
        }

        #workspaces button.active {
            color: #11111b;
            background: #a6e3a1;
            border-radius: 10px;
        }

        #workspaces button.focused {
            color: #a6adc8;
            background: #eba0ac;
            border-radius: 10px;
        }

        #workspaces button.urgent {
            color: #11111b;
            background: #a6e3a1;
            border-radius: 10px;
        }

        #workspaces button:hover {
            background: #11111b;
            color: #cdd6f4;
            border-radius: 10px;
        }

        #custom-language,
        #custom-updates,
        #custom-caffeine,
        #custom-weather,
        #window,
        #clock,
        #battery,
        #pulseaudio,
        #network,
        #workspaces,
        #tray,
        #backlight {
            background: #1e1e2e;
            padding: 0px 10px;
            margin: 3px 0px;
            margin-top: 10px;
            border: 1px solid #181825;
        }

        #tray {
            border-radius: 10px;
            margin-right: 10px;
        }

        #workspaces {
            background: #1e1e2e;
            border-radius: 10px;
            margin-left: 10px;
            padding-right: 0px;
            padding-left: 5px;
        }

        #custom-caffeine {
            color: #89dceb;
            border-radius: 10px 0px 0px 10px;
            border-right: 0px;
            margin-left: 10px;
        }

        #custom-language {
            color: #f38ba8;
            border-left: 0px;
            border-right: 0px;
        }

        #custom-updates {
            color: #f5c2e7;
            border-left: 0px;
            border-right: 0px;
        }

        #window {
            border-radius: 10px;
            margin-left: 60px;
            margin-right: 60px;
        }

        #clock {
            color: #fab387;
            border-radius: 10px 0px 0px 10px;
            margin-left: 0px;
            border-right: 0px;
        }

        #network {
            color: #f9e2af;
            border-left: 10px;
            border-right: 0px;
        }

        #pulseaudio {
            color: #89b4fa;
            border-left: 10px;
            border-right: 0px;
        }

        #pulseaudio.microphone {
            color: #cba6f7;
            border-left: 0px;
            border-right: 0px;
        }

        #battery {
            color: #a6e3a1;
            border-radius: 0 10px 10px 0;
            margin-right: 10px;
            border-left: 0px;
        }

        #custom-weather {
            border-radius: 0px 10px 10px 0px;
            border-right: 0px;
            margin-left: 0px;
        }
      '';
      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          height = 0;
          modules-left = [
            "clock"
            "custom/weather"
            "hyprland/workspaces"
          ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "tray"
            "pulseaudio"
            "battery"
            "network"
          ];

          "hyprland/window" = {
            format = "{}";
            seperate-outputs = true;
          };
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            on-click = "activate";
            format = " {name} {icon} ";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
            };
            persistent_workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
            };
          };
          "custom/weather" = {
            format = "{}°C";
            tooltip = true;
            interval = 3600;
            exec = "wttrbar --location Aarhus";
            return-type = "json";
          };
          tray = {
            icon-size = 13;
            spacing = 10;
          };
          clock = {
            format = " {:%R   %d/%m}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = "{time} {icon}";
            format-full = "  {capacity}%";
            format-icons = [ "" "" "" "" "" ];
          };
          network = {
            format-wifi = "  {essid}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr}  ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "  Disconnected";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-applet --indicator";
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = " Muted";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" "" ];
            };
            on-click = "pavucontrol";
          };
        };
      };
    };

    home.packages = with pkgs; [
      grim
      qt6.qtwayland
      slurp
      waypipe
      wf-recorder
      wl-mirror
      wl-clipboard
      wlogout
      wtype
      wttrbar # for some reason doesn't seem to work
      pavucontrol
      networkmanagerapplet
    ];
  };
}

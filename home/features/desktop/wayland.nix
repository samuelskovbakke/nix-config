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
        @import "mocha.css";

        * {
          font-family: FontAwesome-Free, FiraCode Nerd Font;
          font-weight: bold;
          font-size: 14px;
          min-height: 0;
        }

        window#waybar {
          background: transparent;
          /*background-color: @crust;*/
          background-color: transparent;
          color: @text;
          transition-property: background-color;
          transition-duration: 0.1s;
          /*border-bottom: 1px solid @overlay1;*/
        }

        #window {
          margin: 8px;
          margin-top: 12px;
          padding-left: 8px;
          padding-right: 8px;
        }

        button {
          box-shadow: inset 0 -3px transparent;
          border: none;
          border-radius: 0;
        }

        button:hover {
          background: inherit;
          color: @mauve;
          border-top: 2px solid @mauve;
        }

        #workspaces button {
          padding: 0 4px;
          margin-top: 4px
        }

        #workspaces button.focused {
          background-color: rgba(0, 0, 0, 0.2);
          color: @rosewater;
          border-top: 2px solid @rosewater;
        }

        #workspaces button.active {
          background-color: rgba(0, 0, 0, 0.2);
          color: @mauve;
          border-top: 2px solid @mauve;
        }

        #workspaces button.urgent {
          background-color: #eb4d4b;
        }

        #pulseaudio,
        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #wireplumber,
        #tray,
        #network,
        #mode,
        #scratchpad
        #custom-weather {
          margin-top: 6px;
          margin-bottom: 2px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 4px;
          padding-right: 4px;
        }

        #clock {
          color: @maroon;
          border-bottom: 2px solid @maroon;
        }

        #clock.date {
          color: @mauve;
          border-bottom: 2px solid @mauve;
        }

        #pulseaudio {
          color: @blue;
          border-bottom: 2px solid @blue;
        }

        #network {
          color: @yellow;
          border-bottom: 2px solid @yellow;
        }

        #tray {
          margin-right: 10px;
        }

        #battery {
          color: @green;
          border-bottom: 2px solid @green;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left>widget:first-child>#workspaces {
          margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right>widget:last-child>#workspaces {
          margin-right: 0;
        }

        #custom-weather {
          margin-top: 6px;
          margin-right: 10px;
          margin-left: 10px;
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
            "custom/weather"
            "hyprland/workspaces"
          ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "tray"
            "network"
            "pulseaudio"
            "battery"
            "clock"
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
              "5" = "";
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
      wttrbar
      pavucontrol
      networkmanagerapplet
    ];
  };
}

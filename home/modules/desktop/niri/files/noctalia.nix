# Focus-ring/border/shadow colors for the noctalia shell integration.
# Same structure on both machines, only the accent palette differs:
# desktop runs tokyonight blue, laptop runs catppuccin mauve.
{hostname, ...}: let
  colors =
    {
      desktop = {
        active = "#7aa2f7";
        inactive = "#1a1b26";
        urgent = "#f7768e";
        shadow = "#15161e70";
        tabInactive = "#003dbe";
        insertHint = "#7aa2f780";
      };
      laptop = {
        active = "#cba6f7";
        inactive = "#1e1e2e";
        urgent = "#f38ba8";
        shadow = "#11111b70";
        tabInactive = "#6b02e9";
        insertHint = "#cba6f780";
      };
    }
    .${hostname};
in ''
  layout {

      focus-ring {
          active-color   "${colors.active}"
          inactive-color "${colors.inactive}"
          urgent-color   "${colors.urgent}"
      }

      border {
          active-color   "${colors.active}"
          inactive-color "${colors.inactive}"
          urgent-color   "${colors.urgent}"
      }

      shadow {
          color "${colors.shadow}"
      }

      tab-indicator {
          active-color   "${colors.active}"
          inactive-color "${colors.tabInactive}"
          urgent-color   "${colors.urgent}"
      }

      insert-hint {
          color "${colors.insertHint}"
      }
  }

  recent-windows {
      highlight {
          active-color "${colors.active}"
          urgent-color "${colors.urgent}"
      }
  }
''

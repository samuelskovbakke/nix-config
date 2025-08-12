{...}: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = false;
      vimAlias = true;

      clipboard.enable = true;

      options = {
        tabstop = 2;
        shiftwidth = 2;
      };

      lsp = {
        formatOnSave = true;
        enable = true;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;

        nix.enable = true;
        python.enable = true;
        markdown.enable = true;
        haskell.enable = true;
        java.enable = true;
        rust.enable = true;
      };

      utility.snacks-nvim = {
        enable = true;
        setupOpts = {
          bigfile.enabled = true;
          quickfile.enabled = true;
          dashboard = {
            enabled = true;

            sections = [
              {section = "header";}
              {
                section = "keys";
                gap = 1;
                padding = 1;
              }
            ];

            preset.keys = [
              {
                action = ":lua Snacks.dashboard.pick('files')";
                desc = " Find File";
                icon = " ";
                key = "f";
              }
              {
                action = ":lua Snacks.dashboard.pick('live_grep')";
                desc = " Find Text";
                icon = " ";
                key = "g";
              }
              {
                action = "ene | startinsert";
                desc = " New File";
                icon = " ";
                key = "n";
              }
              {
                action = ":lua Snacks.dashboard.pick('oldfiles')";
                desc = " Recent Files";
                icon = " ";
                key = "r";
              }
              {
                action = ":qa";
                desc = " Quit";
                icon = " ";
                key = "q";
              }
            ];
          };

          indent.enabled = true;
          input.enabled = true;
          notifier.enabled = true;
          scope.enabled = true;
          # scroll.enabled = true;
          statuscolumn.enabled = false;
          toggle.enabled = false;
          words.enabled = true;
        };
      };

      ui = {
        colorizer = {
          enable = true; # Enables color cues inside the document (handy for css)
          setupOpts = {
            filetypes = {
              "*" = {
                RGB = true;
                rgb_fn = true;
                RRGGBB = true;
                always_update = true;
                css = true;
                mode = "background";
              };
            };
          };
        };

        noice = {
          enable = true;
          setupOpts = {
            lsp = {
              override = {
                "vim.lsp.util.convert_input_to_markdown_lines" = true;
                "vim.lsp.util.stylize_markdown" = true;
                "cmp.entry.get_documentation" = true;
              };
            };
            routes = [
              {
                filter = {
                  event = "msg_show";
                  any = [
                    {find = "%d+L, %d+B";}
                    {find = "; after #%d+";}
                    {find = "; before #%d+";}
                  ];
                };
                view = "mini";
              }
              {
                filter = {
                  event = "msg_showmode";
                };
                view = "notify";
              }
              {
                filter = {
                  event = "msg_showcmd";
                };
                view = "mini";
              }
            ];
            presets = {
              bottom_search = false;
              command_palette = true;
              long_message_to_split = true;
            };
          };
        };
      };

      binds.whichKey = {
        enable = true;
        setupOpts = {
          preset = "helix";
        };
      };

      mini = {
        ai.enable = true;
        icons.enable = true;
        pairs.enable = true;
        surround.enable = true;
      };

      filetree.neo-tree = {
        enable = true;
      };

      navigation.harpoon = {
        enable = true;
      };

      autocomplete.nvim-cmp.enable = true;
      statusline.lualine.enable = true;
      telescope.enable = true;
      visuals.nvim-web-devicons.enable = true;
    };
  };
}

{
  programs.nvf.settings.vim.ui = {
    # modes-nvim.enable = true;

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
          {
            filter = {
              event = "lsp";
              kind = "progress";
            };
            opts = {skip = true;};
          }
        ];

        presets = {
          bottom_search = true; # Search in the bottom
          command_palette = false;
          long_message_to_split = true;
        };

        # Sets commandline in the bottom
        /*
           cmdline = {
          view = "cmdline";
        };
        */

        messages = {
          enabled = false;
        };
      };
    };
  };
}

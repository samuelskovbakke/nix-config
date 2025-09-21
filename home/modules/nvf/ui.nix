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
        ];
        presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
        };
      };
    };
  };
}

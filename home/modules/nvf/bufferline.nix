{...}: {
  programs.nvf.settings.vim.tabline.nvimBufferline = {
    enable = true;
    setupOpts = {
      options = {
        indicator = {
          icon = "▎";
          style = "icon";
        };
        themable = true;
        numbers = "none";
        separator_style = "thick";
        diagnostics = "nvim_lsp";
        always_show_bufferline = true;
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
          {
            filetype = "snacks_layout_box";
          }
        ];
      };
    };
  };
}

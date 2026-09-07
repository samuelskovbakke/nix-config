{...}: {
  programs.nvf.settings.vim.statusline.lualine = {
    enable = true;
    setupOpts.sections.lualine_c = [
      {
        __unkeyed-1 = "diff";
        colored = false;
        diff_color = {
          added = "DiffAdd";
          modified = "DiffChange";
          removed = "DiffDelete";
        };
        symbols = {
          added = " ";
          modified = " ";
          removed = " ";
        };
        separator.right = "";
      }
    ];
  };
}

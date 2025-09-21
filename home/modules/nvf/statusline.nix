{...}: {
  programs.nvf.settings.vim.statusline.lualine = {
    enable = true;
    activeSection.c = [
      ''
        {
          "diff",
          colored = false,
          diff_color = {
            -- Same color values as the general color option can be used here.
            added    = 'DiffAdd',    -- Changes the diff's added color
            modified = 'DiffChange', -- Changes the diff's modified color
            removed  = 'DiffDelete', -- Changes the diff's removed color you
          },
          symbols = {added = " ", modified = " ", removed = " "}, -- Changes the diff symbols
          separator = {right = ''}
        }
      ''
    ];
  };
}

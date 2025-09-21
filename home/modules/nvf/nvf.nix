{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = false;
      vimAlias = true;

      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };

      diagnostics.nvim-lint.enable = true;
      comments.comment-nvim.enable = true;

      binds = {
        whichKey = {
          enable = true;
          setupOpts = {
            preset = "helix";
          };
        };
        cheatsheet.enable = true; # allow quickly opening a categorized list of your shortcuts
        hardtime-nvim.enable = true; # discourage inefficient navigation (e.g., overusing arrow keys)
      };

      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          enable_cursor_hijack = true;
        };
      };

      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
      telescope.enable = true;
      visuals.nvim-web-devicons.enable = true;

      git.enable = true;
    };
  };
}

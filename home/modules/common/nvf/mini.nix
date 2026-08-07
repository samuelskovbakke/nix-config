{...}: {
  programs.nvf.settings.vim.mini = {
    ai.enable = true;
    icons.enable = true;
    surround = {
      enable = true;
      setupOpts = {
        mappings = {
          add = "<leader>sa";
          delete = "<leader>sd";
          find = "<leader>sf";
          find_left = "<leader>sF";
          highlight = "<leader>sh";
          replace = "<leader>sr";
          update_n_lines = "<leader>sn";
        };
      };
    };
  };
}

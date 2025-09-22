{
  programs.nvf.settings.vim.utility = {
    motion.flash-nvim.enable = true;

    snacks-nvim = {
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
  };
}

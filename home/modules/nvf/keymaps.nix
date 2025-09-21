{...}: {
  programs.nvf.settings.vim.keymaps = [
    {
      key = "jj";
      mode = ["i"];
      silent = true;
      action = "<Esc>";
    }

    {
      mode = ["n"];
      key = "<leader>e";
      action = ''
        <cmd>Neotree toggle<cr>
      '';
      desc = "Toggle Neotree";
      silent = true;
    }

    {
      mode = ["n" "x"];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      desc = "Down";
      expr = true;
      silent = true;
    }

    {
      mode = ["n" "x"];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      desc = "Down";
      expr = true;
      silent = true;
    }

    {
      mode = ["n" "x"];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      desc = "Up";
      expr = true;
      silent = true;
    }

    {
      mode = ["n" "x"];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      desc = "Up";
      expr = true;
      silent = true;
    }

    {
      mode = ["n"];
      key = "<C-h>";
      action = "<C-w>h";
      desc = "Go to Left Window";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<C-d>";
      action = "<C-d>zz";
      desc = "Go page down and center";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<C-u>";
      action = "<C-u>zz";
      desc = "Go page up and center";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<C-j>";
      action = "<C-w>j";
      desc = "Go to Lower Window";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<C-k>";
      action = "<C-w>k";
      desc = "Go to Upper Window";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<C-l>";
      action = "<C-w>l";
      desc = "Go to Right Window";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      desc = "Increase Window Height";
    }

    {
      mode = ["n"];
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      desc = "Decrease Window Height";
    }

    {
      mode = ["n"];
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      desc = "Decrease Window Width";
    }

    {
      mode = ["n"];
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      desc = "Increase Window Width";
    }

    {
      mode = ["n"];
      key = "<A-j>";
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      desc = "Move Down";
    }

    {
      mode = ["n"];
      key = "<A-k>";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      desc = "Move Up";
    }

    {
      mode = ["i"];
      key = "<A-j>";
      action = "<esc><cmd>m .+1<cr>==gi";
      desc = "Move Down";
    }

    {
      mode = ["i"];
      key = "<A-k>";
      action = "<esc><cmd>m .-2<cr>==gi";
      desc = "Move Up";
    }

    {
      mode = ["v"];
      key = "<A-j>";
      action = ":<C-u>execute \"'<'>move '>+\" . v:count1<cr>gv=gv";
      desc = "Move Down";
    }

    {
      mode = ["v"];
      key = "<A-k>";
      action = ":<C-u>execute \"'<'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
      desc = "Move Up";
    }

    {
      mode = ["n"];
      key = "<S-h>";
      action = "<cmd>bprevious<cr>";
      desc = "Prev Buffer";
    }

    {
      mode = ["n"];
      key = "<S-l>";
      action = "<cmd>bnext<cr>";
      desc = "Next Buffer";
    }

    {
      mode = ["n"];
      key = "[b";
      action = "<cmd>bprevious<cr>";
      desc = "Prev Buffer";
    }

    {
      mode = ["n"];
      key = "]b";
      action = "<cmd>bnext<cr>";
      desc = "Next Buffer";
    }

    {
      mode = ["n"];
      key = "<leader>bb";
      action = "<cmd>e #<cr>";
      desc = "Switch to Other Buffer";
    }

    {
      mode = ["n"];
      key = "<leader>`";
      action = "<cmd>e #<cr>";
      desc = "Switch to Other Buffer";
    }

    {
      mode = ["n"];
      key = "<leader>bd";
      action = ''
        function()
          Snacks.bufdelete()
        end
      '';
      desc = "Delete Buffer";
      lua = true;
    }

    {
      mode = ["n"];
      key = "<leader>bo";
      action = ''
        function()
          Snacks.bufdelete.other()
        end
      '';
      desc = "Delete Other Buffers";
      lua = true;
    }

    {
      mode = ["n"];
      key = "<leader>bD";
      action = "<cmd>:bd<cr>";
      desc = "Delete Buffer and Window";
    }

    {
      mode = ["i" "n" "s"];
      key = "<esc>";
      action = ''
        function()
          vim.cmd("noh")
          -- LazyVim.cmp.actions.snippet_stop() TODO: replace this with something else
          return "<esc>"
        end
      '';
      expr = true;
      lua = true;
      desc = "Escape and Clear hlsearch";
    }

    {
      mode = ["n"];
      key = "<leader>ur";
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      desc = "Redraw / Clear hlsearch / Diff Update";
    }

    {
      mode = ["n"];
      key = "n";
      action = "'Nn'[v:searchforward].'zv'";
      expr = true;
      desc = "Next Search Result";
    }

    {
      mode = ["x"];
      key = "n";
      action = "'Nn'[v:searchforward]";
      expr = true;
      desc = "Next Search Result";
    }

    {
      mode = ["o"];
      key = "n";
      action = "'Nn'[v:searchforward]";
      expr = true;
      desc = "Next Search Result";
    }

    {
      mode = ["n"];
      key = "N";
      action = "'nN'[v:searchforward].'zv'";
      expr = true;
      desc = "Prev Search Result";
    }

    {
      mode = ["x"];
      key = "N";
      action = "'nN'[v:searchforward]";
      expr = true;
      desc = "Prev Search Result";
    }

    {
      mode = ["o"];
      key = "N";
      action = "'nN'[v:searchforward]";
      expr = true;
      desc = "Prev Search Result";
    }

    {
      mode = ["i"];
      key = ",";
      action = ",<c-g>u";
    }

    {
      mode = ["i"];
      key = ".";
      action = ".<c-g>u";
    }

    {
      mode = ["i"];
      key = ";";
      action = ";<c-g>u";
    }

    {
      mode = ["i" "x" "n" "s"];
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      desc = "Save File";
    }

    {
      mode = ["n"];
      key = "<leader>K";
      action = "<cmd>norm! K<cr>";
      desc = "Keywordprg";
    }

    {
      mode = ["v"];
      key = "<";
      action = "<gv";
    }

    {
      mode = ["v"];
      key = ">";
      action = ">gv";
    }

    # {
    #   mode = ["n"];
    #   key = "gco";
    #   action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
    #   desc = "Add Comment Below";
    # }
    #
    # {
    #   mode = ["n"];
    #   key = "gcO";
    #   action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
    #   desc = "Add Comment Above";
    # }

    {
      mode = ["n"];
      key = "<leader>dn";
      action = "<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>";
      desc = "Next Diagnostic";
      # lua = true;
    }

    {
      mode = ["n"];
      key = "[d";
      action = "<cmd>diagnostic.jump({count=-1, float=true})<cr>";
      desc = "Prev Diagnostic";
      # lua = true;
    }

    {
      mode = ["n"];
      key = "]e";
      action = "<cmd>diagnostic.jump({severity=vim.diagnostic.severity.ERROR, count=1, float=true})<cr>";
      desc = "Next Error";
      # lua = true;
    }

    {
      mode = ["n"];
      key = "[e";
      action = "<cmd>diagnostic.jump({severity=vim.diagnostic.severity.ERROR, count=-1, float=true})<cr>";
      desc = "Prev Error";
      # lua = true;
    }

    {
      mode = ["n"];
      key = "]w";
      action = "<cmd>diagnostic.jump({severity=vim.diagnostic.severity.WARN, count=1, float=true})<cr>";
      desc = "Next Warning";
      # lua = true;
    }

    {
      mode = ["n"];
      key = "[w";
      action = "<cmd>diagnostic.jump({severity=vim.diagnostic.severity.WARN, count=-1, float=true})<cr>";
      desc = "Prev Warning";
      # lua = true;
    }

    {
      mode = ["n"];
      key = "<leader>qq";
      action = "<cmd>qa<cr>";
      desc = "Quit All";
    }

    {
      mode = ["n"];
      key = "<leader>ui";
      action = "vim.show_pos";
      desc = "Inspect Pos";
      lua = true;
    }

    {
      mode = ["n"];
      key = "<leader>uI";
      action = ''
        function()
          vim.treesitter.inspect_tree()
          vim.api.nvim_input("I")
        end
      '';
      desc = "Inspect Tree";
      lua = true;
    }

    {
      mode = ["n"];
      key = "<leader>-";
      action = "<C-W>s";
      desc = "Split Window Below";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<leader>|";
      action = "<C-W>v";
      desc = "Split Window Right";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<leader>wd";
      action = "<C-W>c";
      desc = "Delete Window";
      noremap = false;
    }

    {
      mode = ["n"];
      key = "<leader><tab>l";
      action = "<cmd>tablast<cr>";
      desc = "Last Tab";
    }

    {
      mode = ["n"];
      key = "<leader><tab>o";
      action = "<cmd>tabonly<cr>";
      desc = "Close Other Tabs";
    }

    {
      mode = ["n"];
      key = "<leader><tab>f";
      action = "<cmd>tabfirst<cr>";
      desc = "First Tab";
    }

    {
      mode = ["n"];
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<cr>";
      desc = "New Tab";
    }

    {
      mode = ["n"];
      key = "<leader><tab>]";
      action = "<cmd>tabnext<cr>";
      desc = "Next Tab";
    }

    {
      mode = ["n"];
      key = "<leader><tab>d";
      action = "<cmd>tabclose<cr>";
      desc = "Close Tab";
    }

    {
      mode = ["n"];
      key = "<leader><tab>[";
      action = "<cmd>tabprevious<cr>";
      desc = "Previous Tab";
    }
  ];
}

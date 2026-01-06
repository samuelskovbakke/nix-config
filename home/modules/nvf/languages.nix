{
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true; # Shows that a complete option might be a function or a module...
      lspsaga.enable = true; # Code action, hover doc, signature help, preview definition, ...
      trouble.enable = true; # Window to search through errors and warnings.
      lspSignature.enable = false; # Shows a method signature, i.e. which arguments it takes etc.
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      nix = {
        enable = true;
        lsp.servers = ["nixd"];
      };
      python = {
        enable = true;
        lsp.servers = ["pyright"]; # Default: basedpyright
      };
      typst.enable = true;
      lua.enable = true;
      markdown = {
        enable = true;
        extensions = {
          render-markdown-nvim.enable = true;
        };
      };
      haskell.enable = true;
      java.enable = true;
      rust.enable = true;
      css.enable = true;
    };
  };
}

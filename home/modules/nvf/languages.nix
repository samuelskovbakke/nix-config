{pkgs, ...}: {
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
        lsp.server = "nixd";
        lsp.package = pkgs.nixd;
      };
      python = {
        enable = true;
        lsp.server = "pyright"; # Default: basedpyright
      };
      lua.enable = true;
      markdown.enable = true;
      haskell.enable = true;
      java.enable = true;
      rust.enable = true;
      css.enable = true;
    };
  };
}

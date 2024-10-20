{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.zsh;
in
{
  options.features.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    home.file.".p10k.zsh".source = ../../samuel/.dotfiles/.p10k.zsh;
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      plugins = [
        # To add plugins, you can use the following syntax:
        # {
        #   name = "zsh-you-should-use";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "MichaelAquilina";
        #     repo = "zsh-you-should-use";
        #     rev = "1.9.0"; # Update this if a new version is available
        # Hashes are obtained with nix-prefetch-url --unpack https://github.com/MichaelAquilina/zsh-you-should-use/archive/refs/tags/1.9.0.tar.gz
        #     sha256 = "1kb11rqhmsnv3939prb9f00c1giqy3200sjnhh7cxcfjcncq0y7v";
        #   };
        #   file = "you-should-use.plugin.zsh";
        # }
        {
          name = "zsh-you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-you-should-use";
            rev = "1.9.0"; # Update this if a new version is available
            sha256 = "1kb11rqhmsnv3939prb9f00c1giqy3200sjnhh7cxcfjcncq0y7v"; # Adjust if needed
          };
          file = "you-should-use.plugin.zsh";
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "thefuck"
          "tmux"
          "command-not-found"
        ];
      };
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh
        eval $(thefuck --alias)
        # You can use whatever you want as an alias, like for Mondays:
        eval $(thefuck --alias fk)
        fastfetch
      '';
      shellAliases = {
        q = "exit";
        c = "clear";
        cat = "bat";
        ls = "eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions";
        la = "eza --long --all --color=always --git --icons=always --no-time --no-user";
        l = "eza --long --color=always --git --no-filesize --icons=always --no-time --no-user";
        more = "most";
        pac = "sudo pacman --noconfirm";
        yay = "yay --noconfirm";
        give-me-upgrade = "sudo pacman --noconfirm -Syyuu && yay";
        grep = "rg";
        ff = "fastfetch";

        "..." = "../..";
        "...." = "../../..";
        "....." = "../../../..";
        "......" = "../../../../..";

        "1" = "cd -1";
        "2" = "cd -2";
        "3" = "cd -3";
        "4" = "cd -4";
        "5" = "cd -5";
        "6" = "cd -6";
        "7" = "cd -7";
        "8" = "cd -8";
        "9" = "cd -9";

        md = "mkdir -p";
        rd = "rmdir";
        cd = "z";
      };
    };
  };
}

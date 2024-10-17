{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    home.file.".p10k.zsh".source = ../../samuel/.dotfiles/.p10k.zsh;
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
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
        set -x NIX_PATH nixpkgs=channel:nixos-unstable
        set -x NIX_LOG info
        set -x TERMINAL kitty

        if test (tty) = "/dev/tty1"
          exec Hyprland &> /dev/null
        end

        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.pk10k.zsh

        function d () {
          if [[ -n $1 ]]; then
            dirs "$@"
          else
            dirs -v | head -n 10
          fi
        }
        compdef _dirs d
      '';
      shellAliases = {
        q="exit";
        c="clear";
        cat="bat";
        ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions";
        la="eza --long --all --color=always --git --icons=always --no-time --no-user";
        l="eza --long --color=always --git --no-filesize --icons=always --no-time --no-user";
        more="most";
        pac="sudo pacman --noconfirm";
        yay="yay --noconfirm";
        give-me-upgrade="sudo pacman --noconfirm -Syyuu && yay";
        grep="rg";
        ff="fastfetch";

        "..."="../..";
        "...."="../../..";
        "....."="../../../..";
        "......"="../../../../..";

        -- -="cd -";
        "1"="cd -1";
        "2"="cd -2";
        "3"="cd -3";
        "4"="cd -4";
        "5"="cd -5";
        "6"="cd -6";
        "7"="cd -7";
        "8"="cd -8";
        "9"="cd -9";

        md="mkdir -p";
        rd="rmdir";
        cd="z";
        thefuck = "fk";
      };
    };
  };
}

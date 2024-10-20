{
  config,
  lib,
  pkgs,
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
      autosuggestion.enable = true;
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
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh
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

{pkgs, ...}: {
  # Fully declarative fish setup. Previously this was managed by fisher
  # (see fish_plugins) with the actual plugin files symlinked in from
  # ~/dotfiles. Plugins are now nix packages, so fisher is no longer needed.
  programs.fish = {
    enable = true;

    shellAliases = {
      c = "clear";
      cat = "bat";
      cd = "z";
      ff = "fastfetch";
      gg = "lazygit";
      grep = "rg";
      l = "eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions --long";
      la = "eza --long --all --color=always --git --icons=always";
      ll = "eza --long --color=always --git --icons=always";
      ls = "eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      more = "most";
      nrs = "nh os switch --impure";
      pac = "sudo pacman --noconfirm";
      pacupg = "sudo pacman --noconfirm -Syyuu && yay";
      q = "exit";
      yay = "yay --noconfirm";
    };

    shellAbbrs = {
      nixupg = "nix flake update --flake ~/nix-config && nh os switch --impure";
      nixdelgens = "nh clean all && nrs";
      md = "mkdir -p";
      rd = "rmdir";
    };

    functions = {
      # Directory history viewer: `d` on its own shows the last 10 entries,
      # `d <n>` (or any arg) hands off to dirh directly.
      d = ''
        if set -q argv[1]
            dirh
        else
            dirh | head -n 10
        end
      '';
    };

    shellInit = ''
      # Theming
      set -g fish_color_autosuggestion 707A8C
      set -g fish_color_cancel --reverse
      set -g fish_color_command 5CCFE6
      set -g fish_color_comment 5C6773
      set -g fish_color_cwd 73D0FF
      set -g fish_color_cwd_root red
      set -g fish_color_end F29E74
      set -g fish_color_error FF3333
      set -g fish_color_escape 95E6CB
      set -g fish_color_history_current --bold
      set -g fish_color_host --reset
      set -g fish_color_host_remote yellow
      set -g fish_color_normal CBCCC6
      set -g fish_color_operator FFCC66
      set -g fish_color_param CBCCC6
      set -g fish_color_quote BAE67E
      set -g fish_color_redirection D4BFFF
      set -g fish_color_search_match --bold --background=FFCC66
      set -g fish_color_selection --bold --background=FFCC66
      set -g fish_color_status red
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline=single
      set -g fish_pager_color_completion --reset
      set -g fish_pager_color_description B3A06D
      set -g fish_pager_color_prefix --bold --underline=single
      set -g fish_pager_color_progress brwhite --bold --background=cyan
      set -g fish_pager_color_selected_background --background=FFCC66
      set -g fish_pager_color_selected_completion
      set -g fish_pager_color_selected_description
      set -g fish_pager_color_selected_prefix

      # `..`, `...`, `....`, ... up to 10 dots: cd up N-1 directories.
      # Generated dynamically since the function names aren't known ahead of time.
      for n in (seq 2 10)
          set dots (string repeat -n $n .)
          set path (string repeat -n (math "$n - 1") ../)

          eval "
              function $dots
                  cd $path
              end
          "
      end

      zoxide init fish | source
    '';

    interactiveShellInit = ''
      set -U fish_greeting ""
      fetch --infinite

      set -g fish_key_bindings fish_vi_key_bindings

      pay-respects fish | source
    '';

    plugins = [
      # Prompt
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      # fzf keybindings (jethrokuan/fzf, not PatrickF1/fzf.fish)
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      # Removes failed commands from history
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      # git aliases (gaa, gc, gp!, etc)
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      # Auto-close brackets/quotes
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      # shoriminimoe/fish-extract and vitallium/tokyonight-fish aren't
      # packaged in nixpkgs, so they're pulled straight from GitHub.
      {
        name = "fish-extract";
        src = pkgs.fetchFromGitHub {
          owner = "shoriminimoe";
          repo = "fish-extract";
          rev = "main";
          hash = "sha256-pMQcM2mbWBgPVmu5027/ZoXTTZHrKMA4hwteznesUfo=";
        };
      }
      {
        name = "tokyonight-fish";
        src = pkgs.fetchFromGitHub {
          owner = "vitallium";
          repo = "tokyonight-fish";
          rev = "main";
          hash = "sha256-be5gqCl7yfb0zm43ew8YB7BZ37o5bFGE/YXcLUIoIrA=";
        };
      }
    ];
  };
}

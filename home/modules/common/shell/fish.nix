{pkgs, ...}: {
  programs = {
    # Sets fish as my default nix-shell shell.
    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };

    fish = {
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

        if not set -q IN_NIX_SHELL
            fetch --infinite
        end

        set -g fish_key_bindings fish_vi_key_bindings

        pay-respects fish | source

        ssh-add -l >/dev/null 2>&1; or ssh-add ~/.ssh/id_ed25519
      '';

      plugins = [
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
  };
}

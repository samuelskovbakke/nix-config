{pkgs, ...}: {
  programs = {
    # Sets fish as my default nix-shell shell.
    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };

    # Prompt
    starship = {
      enable = true; # fish integration is on by default
      enableTransience = true; # collapses old prompts to just the character
      settings = {
        add_newline = true;

        format = "$hostname\${custom.ssh_ip}$directory$git_branch$git_status$nix_shell$fill $cmd_duration$time$line_break$character";

        fill = {
          symbol = "·";
          style = "bright-black";
        };

        directory = {
          truncate_to_repo = true; # anchor on the repo root
          truncation_length = 8;
          fish_style_pwd_dir_length = 1; # abbreviate directories instead of cutting them
          repo_root_style = "bold purple"; # highlight the anchor, like Tide/p10k
          style = "cyan";
        };

        cmd_duration = {
          min_time = 3000; # only show for commands taking 3s+
          format = "[$duration]($style) ";
          style = "yellow";
        };

        time = {
          disabled = false; # off by default
          format = "[$time]($style)";
          time_format = "%H:%M:%S";
          style = "bright-black";
        };

        custom.ssh_ip = {
          command = "echo $SSH_CONNECTION | cut -d' ' -f3";
          when = ''test -n "$SSH_CONNECTION"''; # only inside an SSH session
          format = "[$output]($style) ";
          style = "bold yellow";
        };

        # Only shown inside an SSH session, so you can tell you're not on your desktop
        hostname = {
          ssh_only = true;
          ssh_symbol = "🌐";
          format = "[$ssh_symbol$hostname]($style)";
          style = "bold yellow";
        };

        nix_shell = {
          symbol = "❄ ";
          format = "[$symbol nix-shell $state]($style)";
          impure_msg = "";
          pure_msg = "(pure)";
          style = "bold blue";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold yellow";

          # Uncommitted work (counts)
          staged = "[+\${count}](green)";
          modified = "!\${count}";
          deleted = "✘\${count}";
          untracked = "?\${count}";
          renamed = "»\${count}";
          conflicted = "=\${count}";
          stashed = "*\${count}";

          # Commits vs. the remote
          ahead = "⇡\${count}"; # committed locally, not pushed
          behind = "⇣\${count}"; # waiting to be pulled
          diverged = "⇡\${ahead_count}⇣\${behind_count}";
          up_to_date = "";
        };

        # Works with your vi key bindings
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };
      };
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

        if not set -q IN_NIX_SHELL
            fetch --infinite
        end

        set -g fish_key_bindings fish_vi_key_bindings

        pay-respects fish | source

        ssh-add -l >/dev/null 2>&1; or ssh-add ~/.ssh/id_ed25519
      '';

      plugins = [
        # Prompt
        /*
        {
          name = "tide";
          src = pkgs.fishPlugins.tide.src;
        }
        */
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

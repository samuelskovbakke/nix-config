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

        format = "$username$hostname\${custom.ssh_ip}\${custom.path_root}\${custom.path_rest} $git_branch$git_status$jobs$nix_shell$fill $status$cmd_duration$time$line_break$character";

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

        custom = {
          # Repo root only: ~/nix-config (hidden outside git repos)
          path_root = {
            command = "${pkgs.writeShellScript "path-root" ''
              root=$(${pkgs.git}/bin/git rev-parse --show-toplevel 2>/dev/null) || exit 0
              case "$root" in
                "$HOME"*) printf '~%s' "''${root#"$HOME"}" ;;
                *)        printf '%s' "$root" ;;
              esac
            ''}";
            when = "${pkgs.git}/bin/git rev-parse --is-inside-work-tree";
            format = "[$output]($style)";
            style = "bold purple";
          };

          # Everything below the root (or the whole path outside a repo), abbreviated
          path_rest = {
            command = "${pkgs.writeShellScript "path-rest" ''
              root=$(${pkgs.git}/bin/git rev-parse --show-toplevel 2>/dev/null)
              if [ -n "$root" ]; then
                rel=''${PWD#"$root"}
              else
                case "$PWD" in
                  "$HOME"*) rel="~''${PWD#"$HOME"}" ;;
                  *)        rel="$PWD" ;;
                esac
              fi
              printf '%s' "$rel" | ${pkgs.gawk}/bin/awk -F/ -v keep=3 -v len=1 '{
                for (i = 1; i <= NF; i++) {
                  if (i > 1) printf "/"
                  if (i > 1 && i <= NF - keep) {
                    n = (substr($i, 1, 1) == ".") ? len + 1 : len
                    printf "%s", substr($i, 1, n)
                  } else {
                    printf "%s", $i
                  }
                }
              }'
            ''}";
            when = true;
            format = "[$output]($style)";
            style = "cyan";
          };

          ssh_ip = {
            command = "echo $SSH_CONNECTION | cut -d' ' -f3";
            when = ''test -n "$SSH_CONNECTION"''; # only inside an SSH session
            format = "[$output]($style) ";
            style = "bold yellow";
          };
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

        status = {
          disabled = false;
          format = "[$symbol$status]($style) ";
          symbol = "✘";
          style = "bold red";
        };

        jobs = {
          symbol = "✦";
          format = "[$symbol$number]($style) ";
          style = "bold blue";
        };

        username = {
          show_always = false;
          format = "[$user]($style) ";
          style_root = "bold red";
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

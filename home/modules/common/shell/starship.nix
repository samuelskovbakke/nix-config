{pkgs, ...}: {
  # Shell Prompt
  programs.starship = {
    enable = true; # fish integration is on by default
    enableTransience = true; # collapses old prompts to just the character
    settings = {
      add_newline = true;

      format = "\${custom.is_ssh}$username$hostname\${custom.ssh_ip}\${custom.path_root}\${custom.path_rest} $git_branch$git_status$jobs$nix_shell$fill $status$cmd_duration$time$line_break$character";

      fill = {
        symbol = "·";
        style = "bright-black";
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
          style = "bold cyan";
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
          format = " [$output]($style) ";
          style = "bold green";
        };

        is_ssh = {
          format = "[󰒋]($style) ";
          style = "bold blue";
          when = ''test -n "$SSH_CONNECTION"''; # only inside an SSH session
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
        format = "[$user]($style)[@](bold green)";
        style_root = "bold red";
        style_user = "bold cyan";
      };

      # Only shown inside an SSH session, so you can tell you're not on your desktop
      hostname = {
        ssh_only = true;
        # ssh_symbol = "󰒋";
        format = "[$hostname]($style)";
        style = "bold cyan";
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
}

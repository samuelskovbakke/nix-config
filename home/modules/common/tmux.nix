{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    focusEvents = true;
    escapeTime = 10;
    terminal = "tmux-256color";
    prefix = "C-a";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      continuum # auto-saves sessions every 15 minutes
      {
        # fabioluciano/tmux-tokyo-night, not packaged in nixpkgs.
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-tokyo-night";
          version = "unstable";
          src = pkgs.fetchFromGitHub {
            owner = "fabioluciano";
            repo = "tmux-tokyo-night";
            rev = "main";
            hash = "sha256-0Ri5S195hPP8xqOVA1h+txwadnjY9slnwCsXQAzrf4o=";
          };
        };
      }
    ];

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      unbind C-b
      bind-key C-a send-prefix

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.tmux.conf

      bind j resize-pane -D 5
      bind k resize-pane -U 5
      bind l resize-pane -R 5
      bind h resize-pane -L 5

      bind -r m resize-pane -Z

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      unbind -T copy-mode-vi MouseDragEnd1Pane

      set-environment -g PATH "/usr/local/bin:/bin:/usr/bin"
    '';
  };
}

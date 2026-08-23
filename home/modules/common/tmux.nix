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
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      continuum # auto-saves sessions every 15 minutes
      {
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-powerkit";
          version = "unstable";
          rtpFilePath = "tmux-powerkit.tmux";
          src = pkgs.fetchFromGitHub {
            owner = "fabioluciano";
            repo = "tmux-powerkit";
            rev = "v7.1.0";
            hash = "sha256-3YbEkLpwGyCWPC9pJDVr7S6tWluzXKtQhZIgfS9VWvI=";
          };
        };
        extraConfig = ''
          set -g @powerkit_theme "tokyo-night"
          set -g @powerkit_theme_variant "night"
        '';
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
      bind r source-file ~/.config/tmux/tmux.conf

      bind j resize-pane -D 5
      bind k resize-pane -U 5
      bind l resize-pane -R 5
      bind h resize-pane -L 5

      bind -r m resize-pane -Z

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      unbind -T copy-mode-vi MouseDragEnd1Pane

      bind-key -n C-h if -F "#{@pane-is-vim}" "send-keys C-h" "select-pane -L"
      bind-key -n C-j if -F "#{@pane-is-vim}" "send-keys C-j" "select-pane -D"
      bind-key -n C-k if -F "#{@pane-is-vim}" "send-keys C-k" "select-pane -U"
      bind-key -n C-l if -F "#{@pane-is-vim}" "send-keys C-l" "select-pane -R"

      bind-key -n C-Up    if -F "#{@pane-is-vim}" "send-keys C-Up"    "resize-pane -U 3"
      bind-key -n C-Down  if -F "#{@pane-is-vim}" "send-keys C-Down"  "resize-pane -D 3"
      bind-key -n C-Left  if -F "#{@pane-is-vim}" "send-keys C-Left"  "resize-pane -L 3"
      bind-key -n C-Right if -F "#{@pane-is-vim}" "send-keys C-Right" "resize-pane -R 3"
    '';
  };
}

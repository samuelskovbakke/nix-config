{
  programs.sesh = {
    enable = true;
    enableAlias = true; # `s` shell alias to launch the picker
    enableTmuxIntegration = true; # wires a tmux keybinding automatically
    icons = true;
    tmuxKey = "T"; # matches what we'd bound manually before

    settings = {
      default_session.startup_command = "nvim .";

      session = [
        {
          name = "nix-config";
          path = "~/nix-config";
          startup_command = "nvim .";
        }
      ];

      wildcard = [
        {
          pattern = "~/repositories/*";
          startup_command = "nvim .";
        }
      ];
    };
  };
}

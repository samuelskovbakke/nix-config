{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      AddKeysToAgent = "yes";
    };
  };

  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "samuelskovbakke";
        email = "samuel@skovbakke.dk";
      };

      init.defaultBranch = "main";

      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}

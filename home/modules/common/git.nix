{...}: {
  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      user = {
        name = "samuelskovbakke";
        email = "samuel@skovbakke.dk";
      };
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}

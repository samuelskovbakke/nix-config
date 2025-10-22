{...}: {
  programs.git = {
    enable = true;
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

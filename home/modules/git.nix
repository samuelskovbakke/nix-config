{ ... }:{
  programs.git = {
    enable = true;
    userName = "samuelskovbakke";
    userEmail = "samuel@skovbakke.dk";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}

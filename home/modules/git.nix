{ ... }:{
  programs.git = {
    enable = true;
    userName = "samuelskovbakke";
    userEmail = "samuel@skovbakke.dk";
    extraConfig = {
      credential.helper = "oauth";
    };
  };
}

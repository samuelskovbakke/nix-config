{ pkgs, ... }:{
  programs.git = {
    enable = true;
    userName = "samuelskovbakke";
    userEmail = "samuel@skovbakke.dk";
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
}

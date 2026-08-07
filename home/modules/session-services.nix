{pkgs, ...}: {
  home.packages = with pkgs; [
    polkit_gnome
  ];

  systemd.user.services.polkit-gnome-agent = {
    Unit = {
      Description = "GNOME Polkit Authentication Agent";
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Environment = [
        "GTK_THEME=Catppuccin-Mocha-Standard-Sky-Dark"
      ];
      Restart = "on-failure";
    };

    Install.WantedBy = ["graphical-session.target"];
  };

  # Secret portal backend (org.freedesktop.impl.portal.Secret), nothing
  # was providing this before, so apps using libsecret (browsers, VSCode,
  # etc.) had nowhere to store credentials. Also starts the ssh-agent and
  # pkcs11 components.
  services.gnome-keyring = {
    enable = true;
    components = ["pkcs11" "secrets" "ssh"];
  };
}

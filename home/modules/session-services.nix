{pkgs, ...}: {
  /*
  systemd.user.services.polkit-kde-agent = {
    Unit = {
      Description = "polkit-kde-authentication-agent-1";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  home.packages = [pkgs.kdePackages.qqc2-breeze-style];
  */

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

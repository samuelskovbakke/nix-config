{user, ...}: {
  services = {
    fwupd.enable = true;

    /*
    qbittorrent = {
      enable = true;
      openFirewall = true;
      webuiPort = 9999;
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences = {
          WebUI = {
            Username = "admin";
            Password_PBKDF2 = "ARQ77eY1NUZaQsuDHbIMCA==:0WMRkYTUWVT9wVvdDtHAjU9b3b7uB8NR1Gur2hmQCvCDpm39Q+PsJRJPaCU51dEiz+dTzh8qbPsL8WkFljQYFQ==";
            // pass: adminadmin
          };
          General.Locale = "en";
        };
      };
    };
    */

    tailscale = {
      enable = true;
    };

    searx = {
      enable = true;
      environmentFile = "/home/${user}/.searxng.env";
      settings = {
        general = {
          debug = false;
        };
        server = {
          bind_address = "127.0.0.1";
          server.port = 8080;
          secret_key = "$SEARX_SECRET_KEY";
        };
      };
    };
  };
}

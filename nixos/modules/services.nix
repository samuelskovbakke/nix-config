{
  services = {
    fwupd.enable = true;
    searx = {
      enable = true;
      environmentFile = "/home/samuel/.searxng.env";
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

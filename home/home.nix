{
  homeStateVersion,
  user,
  lib,
  host,
  ...
}: {
  imports =
    [./modules/common]
    ++ lib.optionals (host.class == "desktop") [./modules/desktop]
    ++ lib.optionals (host.class == "server") [./modules/server];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  news.display = "silent";
}

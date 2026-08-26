{inputs, ...}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.default = {
      isDefault = true;
      path = "ygsl0z2v.Default Profile";
    };
  };
}

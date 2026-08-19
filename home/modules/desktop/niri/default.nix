{
  lib,
  host ? null,
  ...
}: let
  # host.hostname comes from flake.nix's per-host definitions ("desktop" /
  # "laptop" / ...), threaded through to home-manager via extraSpecialArgs in
  # nixos/modules/home-manager.nix.
  hostname = host.hostname or "laptop";
  args = {inherit hostname lib;};

  # Truly static, identical on both machines.
  staticFiles = ["config.kdl" "env.kdl" "layout.kdl" "swipe-window.kdl"];

  # Generated from a shared template: same file, with lib.optionalString /
  # if-then-else picking the host-specific blocks/values at build time.
  # See files/*.nix -- each takes {hostname, lib} and returns the final
  # KDL text for that host.
  generatedFiles = {
    "monitors.kdl" = import ./files/monitors.nix args;
    "input.kdl" = import ./files/input.nix args;
    "noctalia.kdl" = import ./files/noctalia.nix args;
    "rules.kdl" = import ./files/rules.nix args;
    "startup.kdl" = import ./files/startup.nix args;
    "binds-noctalia.kdl" = import ./files/binds-noctalia.nix args;
  };
in {
  assertions = [
    {
      assertion = builtins.elem hostname ["desktop" "laptop" "worktop"];
      message = "niri module: no per-host niri config for host.hostname \"${hostname}\" (expected \"desktop\", \"laptop\" or \"worktop\")";
    }
  ];

  xdg.configFile =
    lib.foldl' (acc: name: acc // {"niri/${name}".source = ./files/${name};}) {} staticFiles
    // lib.mapAttrs' (name: text: lib.nameValuePair "niri/${name}" {inherit text;}) generatedFiles
    // lib.optionalAttrs (hostname == "desktop") {
      # Only desktop's startup.kdl / binds-noctalia.kdl reference these.
      "niri/scripts".source = ./files/scripts;
    };
}

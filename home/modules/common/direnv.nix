{
  # Enables direnv + nix-direnv so that per-project `flake.nix` devShells
  # (Python venvs, C toolchains, etc.) auto-load when I `cd` into a project
  # with a `.envrc` containing `use flake`, and auto-unload when I leave.
  #
  # This lets project-specific package versions (e.g. a pinned Python + libs,
  # or a specific gcc/cmake setup) take precedence on $PATH over the global
  # toolchains in home-packages.nix, without needing to change global config
  # per project. nix-direnv adds caching so shells don't rebuild on every cd.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };
}

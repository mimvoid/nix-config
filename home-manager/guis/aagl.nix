{ inputs, pkgs, ... }:

{
  # cachix set up in configuration.nix

  home.packages =
    with inputs.aagl.packages.${pkgs.system};
    [
      an-anime-game-launcher
      honkers-railway-launcher
    ];
}

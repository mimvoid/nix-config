{ inputs, ... }:

[
  # Overlays provided by inputs
  # Usually, just use pkgs.<package>
  inputs.fletchling.overlay

  (final: prev: {
    # Allows nixpkgs-unstable to be referenced
    # Use pkgs.unstable.<package>
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) config;
      inherit (final.stdenv.hostPlatform) system;
    };

    # Set of custom packages
    # Use pkgs.voids.<package>
    voids = (import ../pkgs { inherit (final) pkgs; }) // {
      # A set of custom functions
      # Use pkgs.voids.lib.<function> <parameter values>
      lib = import ./lib.nix { inherit (final.pkgs) lib; };
    };

    # Set of modified existing packages
    # Use pkgs.mods.<package>
    mods = import ./mods.nix { inherit final prev; };

    # Defined palettes & functions to manipulate palettes
    # Use pkgs.palettes.<name>
    palettes = import ./palettes { inherit (final) pkgs; };

    # Other variables regarding theming (e.g. fonts, icons, etc.)
    # Use pkgs.theme.<name>
    theme = import ./theme.nix { inherit (final) pkgs; };
  })
]

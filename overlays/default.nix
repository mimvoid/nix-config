{ inputs, ... }:

# Exports a list of overlays

let
  # Allows nixpkgs-unstable to be referenced
  # Use pkgs.unstable.<package>
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system config;
    };
  };

  # Overlays provided by inputs
  # Usually, just use pkgs.<package>
  input-overlays = with inputs; [
    dooit.overlay
    dooit-extras.overlay
    fletchling.overlay
  ];

  # A set of custom functions
  # Use pkgs.my-utils.<function> <parameter values>
  utils = final: _prev: {
    my-utils = import ./utils.nix { inherit (final.pkgs) lib; };
  };

  # Get the set of custom packages
  # Use pkgs.voids.<package>
  additions = final: _prev: {
    voids = import ../pkgs { inherit (final) pkgs; };
  };

  # Get the set of modified existing packages
  # Use pkgs.mods.<package>
  modifications = final: _prev: {
    mods = import ./mods.nix { inherit final _prev; };
  };

  # Defined palettes & functions to manipulate palettes
  # Use pkgs.palettes.<name>
  my-palettes = final: _prev: {
    palettes = import ./palettes { pkgs = final.pkgs.unstable; };
  };
in
[
  unstable-packages
  utils
  additions
  modifications
  my-palettes
]
++ input-overlays

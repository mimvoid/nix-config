{ inputs, ... }:

# Exports a list of overlays

let
  # Allows nixpkgs-unstable to be referenced
  # Use pkgs.unstable.<package>
  unstable-packages = final: _: {
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

  additions = final: _: {
    voids =
      # Get the set of custom packages
      # Use pkgs.voids.<package>
      (import ../pkgs { inherit (final) pkgs; })
      // {
        # A set of custom functions
        # Use pkgs.voids.lib.<function> <parameter values>
        lib = import ./lib.nix { inherit (final.pkgs) lib; };
      };
  };

  # Get the set of modified existing packages
  # Use pkgs.mods.<package>
  modifications = final: prev: {
    mods = import ./mods.nix { inherit final prev; };
  };

  theming = final: _: {
    # Defined palettes & functions to manipulate palettes
    # Use pkgs.palettes.<name>
    palettes = import ./palettes { pkgs = final.pkgs.unstable; };

    # Other variables regarding theming (e.g. fonts, icons, etc.)
    # Use pkgs.theme.<name>
    theme = import ./theme.nix { inherit (final) pkgs; };
  };
in
[
  unstable-packages
  additions
  modifications
  theming
]
++ input-overlays

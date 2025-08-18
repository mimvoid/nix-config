{ lib }:

{
  strings = import ./strings.nix { inherit lib; };
  attrsets = import ./attrsets.nix { inherit lib; };
}

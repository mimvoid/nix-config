{ lib }:

{
  strings = import ./strings.nix { inherit lib; };
  attrsets = import ./attrsets.nix { inherit lib; };
  lists = import ./lists.nix { inherit lib; };
}

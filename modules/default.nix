{ lib }:
let
  # Create an attrset of Nix files and their content from a directory.
  importRec =
    dir:
    lib.attrsets.mapAttrs' (
      name: value:
      let
        absPath = "${dir}/${name}";
      in
      {
        name = lib.strings.removeSuffix ".nix" name;
        value = if value == "directory" then importRec absPath else import absPath;
      }
    ) (builtins.readDir dir);
in
{
  nixosModules = importRec ./nixos;
  homeModules = importRec ./home-manager;
}

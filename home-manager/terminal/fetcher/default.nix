{ pkgs, ... }:
let
  fletchling = pkgs.writeShellScriptBin "fletchling" (builtins.readFile ./fetcher.sh);
in
{
  home.packages = [ fletchling ];
}

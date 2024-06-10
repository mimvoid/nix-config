{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./foot.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    dooit
    wttrbar
    wego
  ];
}

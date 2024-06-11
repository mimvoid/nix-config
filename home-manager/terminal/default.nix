{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./foot.nix
    ./sakura.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    dooit
    wttrbar
    wego
  ];
}

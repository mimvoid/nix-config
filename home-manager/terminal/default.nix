{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./foot.nix
    ./yazi.nix
    ./ncmpcpp.nix
  ];

  home.packages = with pkgs; [
    xterm
    dooit
    wttrbar
    wego
  ];
}

{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./foot.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    xterm
    dooit
    wttrbar
    wego
  ];
}

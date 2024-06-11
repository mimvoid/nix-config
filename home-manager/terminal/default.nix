{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./foot.nix
    ./sakura.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    xterm
    dooit
    wttrbar
    wego
  ];
}

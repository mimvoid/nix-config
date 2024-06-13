{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
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

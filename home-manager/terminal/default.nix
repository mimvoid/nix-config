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
    rclone
    dooit
    wttrbar
    wego
  ];
}

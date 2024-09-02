{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    #./foot.nix
    ./kitty.nix
    ./navi/navi.nix
    #./taskwarrior.nix
    #./xterm.nix
    ./yazi.nix
    #./ncmpcpp.nix
  ];

  home.packages = with pkgs; [
    bluetuith

    gotop
    dooit

    (callPackage ../../packages/arttime.nix {})
  ];
}

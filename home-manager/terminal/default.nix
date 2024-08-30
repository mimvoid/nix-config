{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    #./foot.nix
    ./kitty.nix
    ./navi/navi.nix
    #./xterm.nix
    ./yazi.nix
    #./ncmpcpp.nix
  ];

  home.packages = with pkgs; [
    bluetuith

    gotop
    dooit
    
    neocities-cli
    nodePackages.browser-sync

    (callPackage ../../packages/arttime.nix {})
  ];
}

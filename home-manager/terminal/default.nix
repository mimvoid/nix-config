{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./foot.nix
    ./navi/navi.nix
    ./xterm.nix
    ./yazi.nix
    #./ncmpcpp.nix
  ];

  home.packages = with pkgs; [
    unstable.impala
    bluetuith

    gotop
    dooit
    
    neocities-cli
    nodePackages.browser-sync

    (callPackage ../../packages/arttime.nix {})
  ];

  services.ssh-agent.enable = true;
}

{ config, inputs, pkgs, ... }:
let
  mydooit = pkgs.dooit.override {
    extraPackages = with pkgs; [
      dooit-extras
    ];
  };
in
{
  imports = [ ./theme.nix ];

  nixpkgs.overlays = with inputs; [
    dooit.overlay
    dooit-extras.overlay
  ];

  home.packages = [ mydooit ];

  xdg.configFile."dooit/config.py".source = config.lib.file.mkOutOfStoreSymlink /home/zinnia/NixOS/home-manager/terminal/dooit/config.py;
}

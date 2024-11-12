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

  xdg.configFile =
    let
      here = "${config.home.homeDirectory}/NixOS/home-manager/terminal/dooit";

      symlink = src: {
        source = config.lib.file.mkOutOfStoreSymlink "${here}/${src}";
      };
    in
    {
      "dooit/config.py" = symlink "config.py";
      "dooit/settings.py" = symlink "settings.py";
    };
}

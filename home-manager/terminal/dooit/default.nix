{ inputs, pkgs, ... }:
# let
  # mydooit = pkgs.dooit.override {
  #   extraPackages = [
  #     pkgs.dooit-extras
  #   ];
  # };
# in
{
  imports = [
    # ./theme.nix
  ];

  nixpkgs.overlays = with inputs; [
    dooit.overlay
    # dooit-extras.overlay
  ];

  home.packages = [ pkgs.dooit ];

  # xdg.configFile = {
  #   "dooit/config.py".source = ./config.py;
  #   "dooit/extra.py".source = ./extra.py;
  # };
}

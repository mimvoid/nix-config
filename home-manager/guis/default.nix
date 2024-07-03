{ pkgs, lib, allowed-unfree-packages, ... }:

{
  home.packages = with pkgs; [
    # Files & documents
    pdfarranger
    xarchiver
    nextcloud-client
    localsend

    # Academics
    zotero_7
    anki-bin
    anki-sync-server

    # Contact
    zoom-us
    vesktop

    # Virtualisation/layers
    bottles
    virt-manager

    # Media
    amberol
  ];

  imports = [
    ./freetube.nix
    ./zathura.nix
  ];

  # Imports list of allowed unfree packages from flake.nix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
}

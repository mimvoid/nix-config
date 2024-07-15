{ pkgs, lib, allowed-unfree-packages, ... }:

{
  home.packages = with pkgs; [
    # Files & documents
    pdfarranger
    xarchiver

    # Academics
    zotero_7
    anki-bin
    anki-sync-server

    # Contact
    zoom-us
    vesktop

    # Virtualisation/layers
    unstable.bottles
    virt-manager

    # Media
    amberol
  ];

  imports = [
    ./flatpaks.nix
    #./freetube.nix
    ./zathura.nix
  ];

  # Imports list of allowed unfree packages from flake.nix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;

  services.nextcloud-client.enable = true;
}

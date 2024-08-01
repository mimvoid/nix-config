{ pkgs, lib, allowed-unfree-packages, ... }:

{
  home.packages = with pkgs; [
    # Files & documents
    pdfarranger
    xarchiver
    nextcloud-client # Have it available as an app

    # Academics
    zotero_7
    anki-bin
    anki-sync-server

    # Contact
    zoom-us
    vesktop

    # Virtualisation/layers/games
    unstable.bottles
    virt-manager
    unstable.prismlauncher

    # Media
    amberol
    inkscape
  ];

  imports = [
    ./flatpaks.nix
    #./freetube.nix
    ./zathura.nix
  ];

  # Imports list of allowed unfree packages from flake.nix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}

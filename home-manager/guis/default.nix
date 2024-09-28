{ pkgs, lib, allowed-unfree-packages, ... }:

{
  home.packages = with pkgs; [
    # Files & documents
    gnome.file-roller
    pdfarranger
    nextcloud-client # Have it available as an app
    unstable.xournalpp

    # Academics
    unstable.zotero
    unstable.anki-bin
    anki-sync-server

    # Contact
    #zoom-us
    vesktop

    # Virtualisation/layers/games
    unstable.bottles
    unstable.prismlauncher
    virt-manager

    # Media
    tauon
    inkscape
    unstable.krita
    unstable.geeqie
    blanket
  ];

  imports = [
    ./superProductivity/default.nix
    ./flatpaks.nix
    ./zathura.nix
  ];

  # Imports list of allowed unfree packages from flake.nix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  services.syncthing.enable = true;
}

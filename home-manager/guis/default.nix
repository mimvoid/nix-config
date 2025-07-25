{ pkgs, ... }:

{
  imports = [
    ./aagl.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    unstable.obsidian

    # Files & documents
    libreoffice
    file-roller
    nextcloud-client # Have it available as an app

    # Academics
    unstable.zotero
    unstable.anki-bin
    anki-sync-server

    # Social
    vesktop

    # Virtualisation/layers/games
    # unstable.bottles
    # unstable.prismlauncher
    # virt-manager

    # Media
    voids.freetube
    tauon
    # inkscape
    # unstable.digikam
  ];

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
      package = pkgs.unstable.syncthingtray-minimal;
      command = "syncthingtray --wait";
    };
  };
}

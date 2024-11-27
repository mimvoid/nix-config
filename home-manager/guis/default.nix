{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.obsidian
    unstable.qalculate-gtk

    # Files & documents
    file-roller
    # pdfarranger
    nextcloud-client # Have it available as an app
    rnote

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
    tauon
    # inkscape
    unstable.krita
    blanket
  ];

  imports = [
    ./aagl.nix
    ./inlyne.nix
    ./zathura.nix
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

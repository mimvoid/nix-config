{ pkgs, ... }:

{
  imports = [
    ./obsidian
    ./thunar.nix
    ./aagl.nix
    ./zathura.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # Files & documents
      libreoffice
      file-roller
      nextcloud-client # Have it available as an app

      # Media
      tauon
      # inkscape
      # unstable.digikam

      anki-sync-server
      vesktop
      # virt-manager
      ;

    inherit (pkgs.unstable)
      zotero
      anki-bin
      # bottles
      # prismlauncher
      ;

    inherit (pkgs.voids) freetube;
  };

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

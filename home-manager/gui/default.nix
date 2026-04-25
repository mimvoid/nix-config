{ pkgs, ... }:

{
  imports = [
    ./thunar.nix
    ./zathura.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      libreoffice
      file-roller
      nextcloud-client # Have it available as an app

      tauon
      vesktop

      anki-sync-server
      ;

    inherit (pkgs.unstable)
      obsidian
      zotero
      anki-bin
      prismlauncher
      ;
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

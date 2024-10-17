{ pkgs, lib, allow-unfree, ... }:
let
  obsidian = pkgs.callPackage ../../packages/appimages/obsidian.nix {};
  # zen-browser = pkgs.callPackage ../../packages/appimages/zen-browser.nix {};
in
{
  # Imports list of allowed unfree packages from flake.nix
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allow-unfree;

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

    # Social
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
  ] ++ [
    obsidian
  ];

  imports = [
    ./superProductivity/default.nix
    # ./flatpaks.nix
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

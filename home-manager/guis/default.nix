{ pkgs, lib, allowed-unfree-packages, ... }:
let
  # Override the desktop entry file's name
  sp = pkgs.unstable.super-productivity.overrideAttrs (prev: {
    postInstall = (prev.postInstall or "") + ''
      substituteInPlace $out/share/applications/${prev.pname}.desktop \
        --replace "superProductivity" "Super Productivity"
    '';
  });
in
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

    # Virtualisation/layers
    unstable.bottles
    virt-manager

    # Media
    amberol
  ]
  ++
  [
    (sp)
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

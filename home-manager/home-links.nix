{ config, pkgs, ... }:
let
  app-icons = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps";
  symlink = config.lib.file.mkOutOfStoreSymlink;

  home-manager = "${config.home.homeDirectory}/NixOS/home-manager";
  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";

  appimg = {
    obsidian = pkgs.callPackage ../packages/obsidian.nix { version = "1.6.3"; };
    krita = pkgs.callPackage ../packages/krita.nix { version = "5.2.2"; };
  };
in
{
  # Symlinks
  # If you're using flakes, use absolute paths or the symlinks will point to the nix store
  # If you don't do that, it can cause broken links, and nothing will update until a rebuild
  xdg.configFile = {
    "ags" = {
      enable = true;
      source = symlink "${home-manager}/ags";
    };
    "dooit/config.py" = {
      enable = true;
      source = symlink "${home-manager}/terminal/dooit.py";
    };
  };

  xdg.dataFile = {
    "krita/color-schemes/CatppuccinMochaMaroon.colors" = {
      enable = true;
      source = symlink "${home-manager}/krita/CatppuccinMochaMaroon.colors";
    };
    "krita/color-schemes/CatppuccinMacchiatoMaroon.colors" = {
      enable = true;
      source = symlink "${home-manager}/krita/CatppuccinMacchiatoMaroon.colors";
    };

    # TODO: install krita plugins as packages instead of manually
    # Reference Tabs Docker
    "krita/pykrita/reference_tabs" = {
      enable = true;
      source = symlink "${home-manager}/krita/reference-tabs-docker-master/pykrita/reference_tabs";
    };
    "krita/pykrita/reference_tabs.desktop" = {
      enable = true;
      source = symlink "${home-manager}/krita/reference-tabs-docker-master/pykrita/reference_tabs.desktop";
    };

    # Composition helper
    "krita/actions/compositionhelper.action" = {
      enable = true;
      source = symlink "${home-manager}/krita/compositionhelper/compositionhelper.action";
    };
    "krita/pykrita/compositionhelper" = {
      enable = true;
      source = symlink "${home-manager}/krita/compositionhelper/compositionhelper";
    };
    "krita/pykrita/compositionhelper.desktop" = {
      enable = true;
      source = symlink "${home-manager}/krita/compositionhelper/compositionhelper.desktop";
    };
  };

  home.file = {
    ".mozilla/firefox/${firefox-profile}/chrome" = {
      enable = true;
      source = symlink "${home-manager}/firefox/chrome";
    };
    "${obsidian-dir}/.obsidian/snippets" = {
      enable = true;
      source = symlink "${home-manager}/obsidian-css";
    };
  };

  home.packages = [
    (appimg.obsidian)
    (appimg.krita)
  ];

  # Desktop entries
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      icon = "${app-icons}/obsidian.svg";
      exec = "${appimg.obsidian}/bin/Obsidian %u";
      terminal = false;
    };
    krita = {
      name = "Krita";
      icon = "${app-icons}/krita.svg";
      exec = "${appimg.krita}/bin/krita %u";
      terminal = false;
    };
  };
}

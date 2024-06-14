{ config, pkgs, ... }:
let
  app-icons = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps";
  symlink = config.lib.file.mkOutOfStoreSymlink;
  #firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";

  appimg = {
    obsidian = pkgs.callPackage ../packages/obsidian.nix { version = "1.6.3"; };
    krita = pkgs.callPackage ../packages/krita.nix { version = "5.2.2"; };
  };
in
{
  # Symlinks
  xdg.configFile = {
    "ags" = {
      enable = true;
      source = symlink ./ags;
    };
    "dooit/config.py" = {
      enable = true;
      source = symlink ./terminal/dooit.py;
    };
  };
  home.file = {
    # FIXME: somehow doesn't work despite the same exact format?
    #".mozilla/firefox/${firefox-profile}/chrome" = {
    #  enable = true;
    #  source = symlink ./firefox/chrome;
    #};
    "${obsidian-dir}/.obsidian/snippets" = {
      enable = true;
      source = symlink ./obsidian-css;
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

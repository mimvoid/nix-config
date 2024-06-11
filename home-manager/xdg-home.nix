{ config, pkgs, ... }:
let
  app-icons = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps";
  symlink = config.lib.file.mkOutOfStoreSymlink;
  # HACK: can this be more flexible for different directory names?
  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";
in
{
  # Symlinks
  xdg.configFile = {
    "ags" = {
      enable = true;
      source = symlink ./ags;
    };
  };
  home.file = {
    # FIXME: somehow doesn't work despite the same exact format?
    #".mozilla/firefox/${firefox-profile}/chrome" = {
    #  enable = true;
    #  source = symlink ./firefox-config/chrome;
    #};
    "${obsidian-dir}/.obsidian/snippets" = {
      enable = true;
      source = symlink ./obsidian-css;
    };
  };

  # Desktop entries
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      icon = "${app-icons}/obsidian.svg";

      # TODO: what is the variable for an appimageTool package?
      exec = "/nix/store/4vx2sszc7x7pz0fpywdgfncva7dawsky-Obsidian-1.6.3/bin/Obsidian %u";
      terminal = false;
    };
    krita = {
      name = "Krita";
      icon = "${app-icons}/krita.svg";
      exec = "/nix/store/qg5w1h3rq6wg4g9q6d32n82jv48vryss-krita-5.2.2/bin/krita %u";
      terminal = false;
    };
  };
}

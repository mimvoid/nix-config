{ config, ... }:
let
  # Direct (out of store) symlinks

  # If you're using flakes, use absolute paths or the symlinks will point to the nix store.
  # Relative paths can cause broken links, and nothing will update until a rebuild.
  # No need for direct symlinks if you don't need instant updates.

  symlink = src: {
    source = config.lib.file.mkOutOfStoreSymlink src;
  };

  # Directory shorthands
  home-manager = "${config.home.sessionVariables.FLAKE}/home-manager";

  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";
in
{
  xdg = {
    configFile = {
      "ags" = symlink "${home-manager}/ags";
      "gtk-3.0/gtk.css".source = ./xfconf/gtk3.css;
    };

    dataFile."navi/cheats" = symlink "${home-manager}/terminal/navi";
  };

  home.file = {
    # Firefox userChrome & userContent
    ".mozilla/firefox/${firefox-profile}/chrome" = symlink "${home-manager}/firefox/chrome";

    # Obsidian CSS
    "${obsidian-dir}/.obsidian/snippets" = symlink "${home-manager}/obsidian-css";
  };
}

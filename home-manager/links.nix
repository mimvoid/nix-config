{ flakePath, config, ... }:
let
  # Direct (out of store) symlinks

  # If you're using flakes, use absolute paths or the symlinks will point to the nix store.
  # Relative paths can cause broken links, and nothing will update until a rebuild.
  # No need for direct symlinks if you don't need instant updates.

  symlink = src: {
    source = config.lib.file.mkOutOfStoreSymlink src;
  };

  # Directory shorthands
  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";
in
{
  xdg = {
    configFile = {
      "ags" = symlink "${flakePath}/home-manager/ags";
      "wallpapers".source = ../wallpapers/wallpapers;
    };

    dataFile."navi/cheats" = symlink "${flakePath}/home-manager/terminal/navi";
  };

  home.file = {
    # Firefox userChrome & userContent
    ".mozilla/firefox/${firefox-profile}/chrome" = symlink "${flakePath}/home-manager/firefox/panefox";

    # Obsidian CSS
    "${obsidian-dir}/.obsidian/snippets" = symlink "${flakePath}/home-manager/theming/obsidian-css";
  };
}

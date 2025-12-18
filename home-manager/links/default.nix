{ config, ... }:
let
  inherit (config.voids.lib) symlink;
in
{
  xdg.configFile = {
    "ags" = symlink "ags";
    "wallpapers".source = ../../wallpapers/wallpapers;

    "dooit/config.py" = symlink "links/dooit/config.py";
    "dooit/settings/formats.py" = symlink "links/dooit/settings/format.py";
    "dooit/settings/ui.py" = symlink "links/dooit/settings/ui.py";

    "hellwal/templates" = symlink "links/hellwal/templates";
    "hellwal/themes" = symlink "links/hellwal/themes";

    "navi/config.yaml" = symlink "links/navi/config.yaml";
    "navi/cheats" = symlink "links/navi/cheats";

    # "rmpc" = symlinkRec "links/rmpc";
    # "starship.toml" = symlink "links/starship.toml";

    "kitty/hugo" = symlink "links/kitty/hugo.conf";
    "gtk-3.0/gtk.css" = symlink "links/gtk3.css";
  };

  home.file =
    let
      firefox-profile = "30dphuug.default";
      vault-dir = "Documents/Zettelkasten";
    in
    {
      # Firefox userChrome & userContent
      ".mozilla/firefox/${firefox-profile}/chrome" = symlink "firefox/panefox";

      # Obsidian
      "${vault-dir}/.obsidian/snippets" = symlink "links/obsidian/snippets";
      "${vault-dir}/.obsidian.vimrc" = symlink "links/obsidian/.obsidian.vimrc";
    };
}

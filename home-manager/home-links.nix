{ config, pkgs, ... }:
let
  symlink = src: {
    source = config.lib.file.mkOutOfStoreSymlink src;
  };

  # Directory shorthands
  home-manager = "${config.home.homeDirectory}/NixOS/home-manager";

  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";

  appimg = {
    obsidian = pkgs.callPackage ../packages/appimages/obsidian.nix {
      version = "1.6.7";
      sha256 = "Bf5IUjM1oX6gGlwXExAdsvEFPYMKXkKLnBFdmhvYCcU=";
    };
    # zen-browser = pkgs.callPackage ../packages/appimages/zen-browser.nix {};
  };
in
{
  # Direct (out of store) symlinks
  # If you're using flakes, use absolute paths or the symlinks will point to the nix store.
  # Relative paths can cause broken links, and nothing will update until a rebuild.
  # No need for direct symlinks if you don't need instant updates.

  xdg.configFile = {
    "ags" = symlink "${home-manager}/ags";
    "gtk-3.0/gtk.css".source = ./xfconf/gtk3.css;
    "wlogout/icons".source = ./hyprland/icons;
  };

  xdg.dataFile = {
    "navi/cheats" = symlink "${home-manager}/terminal/navi";
  };

  home.file = {
    # Firefox userChrome & userContent
    ".mozilla/firefox/${firefox-profile}/chrome" = symlink "${home-manager}/firefox/chrome";

    # Obsidian CSS
    "${obsidian-dir}/.obsidian/snippets" = symlink "${home-manager}/obsidian-css";
  };


  # AppImage desktop entries
  # See specifications on https://specifications.freedesktop.org/desktop-entry-spec/latest/index.html
  home.packages = [ appimg.obsidian ];

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      icon = "obsidian";
      exec = "${appimg.obsidian}/bin/Obsidian --enable-wayland-ime %u";
      terminal = false;
      categories = [ "Office" ];
    };
   # zen-browser = {
   #   name = "Zen Browser";
   #   icon = "zen";
   #   exec = "${appimg.zen-browser}/bin/zen-browser %u";
   #   terminal = false;
   #   categories = [ "Network" "WebBrowser" ];
   # };
  };
}

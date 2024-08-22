{ config, pkgs, ... }:
let
  link = src: {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${src}";
  };
  
  krita-link = target: source: file: {
    "krita${target}/${file}" = {
      enable = true;
      source = "${source}/${file}";
    };
  };

  # Directory shorthands
  home-manager = "${config.home.homeDirectory}/NixOS/home-manager";

  gpl-pal = "${home-manager}/krita/gpl-palettes/palettes";

  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";

  # Krita plugin packages
  ref-tabs = pkgs.callPackage ../packages/krita/reference-tabs-docker.nix {};
  comp-helper = pkgs.callPackage ../packages/krita/composition-helper.nix {};
  timer-watch = pkgs.callPackage ../packages/krita/timer-watch.nix {};

  appimg = {
    obsidian = pkgs.callPackage ../packages/appimages/obsidian.nix {
      version = "1.6.7";
      sha256 = "Bf5IUjM1oX6gGlwXExAdsvEFPYMKXkKLnBFdmhvYCcU=";
    };
  };
in
{
  # Direct (out of store) symlinks
  # If you're using flakes, use absolute paths or the symlinks will point to the nix store.
  # Relative paths can cause broken links, and nothing will update until a rebuild.
  # No need for direct symlinks if you don't need instant updates.

  xdg.configFile = {
    "ags" = (link "${home-manager}/ags");
    "dooit/config.py".source = ./terminal/dooit/config.py;
    "dooit/extra.py".source = ./terminal/dooit/extra.py;
    "gtk-3.0/gtk.css".source = ./xfconf/gtk3.css;
    "wlogout/icons".source = ./hyprland/icons;
  };

  xdg.dataFile = {
    "navi/cheats" = (link "${home-manager}/terminal/navi");

    # Krita thumbnails
    "thumbnailers/kra.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
      MimeType=application/x-krita;
    '';

    # Palettes
    # Gpl palettes is a submodule and unfortunately unrecognizable for nix
    "krita/palettes/catppuccin-macchiato.gpl" = (link
      "${gpl-pal}/catppuccin/catppuccin-macchiato.gpl");
    "krita/palettes/rose-pine-moon.gpl" = (link
      "${gpl-pal}/rose-pine/rose-pine-moon.gpl");
    "krita/palettes/ayu-mirage.gpl" = (link
      "${gpl-pal}/ayu/ayu-mirage.gpl");
  }
  # Resources (brushes, packs, etc.)
  // (krita-link "" ./krita "Chalks_for_Children.bundle")
  // (krita-link "" ./krita "hollow_line.bundle")
  // (krita-link "" ./krita "SK_V1_.bundle")
  // (krita-link "" ./krita "Rakurri_Gradient_Map_Set_V1.0.bundle")

  # Themes
  // (krita-link "/color-schemes" ./krita "CatppuccinMochaMaroon.colors")
  // (krita-link "/color-schemes" ./krita "CatppuccinMacchiatoMaroon.colors")

  # Plugins
  # Reference Tabs Docker
  // (krita-link "/pykrita" "${ref-tabs}/pykrita" "reference_tabs")
  // (krita-link "/pykrita" "${ref-tabs}/pykrita" "reference_tabs.desktop")

  # Composition Helper
  // (krita-link "/pykrita" "${comp-helper}/pykrita" "compositionhelper")
  // (krita-link "/pykrita" "${comp-helper}/pykrita" "compositionhelper.desktop")
  // (krita-link "/actions" "${comp-helper}/actions" "compositionhelper.action")

  # Timer Watch
  // (krita-link "/pykrita" "${timer-watch}/pykrita" "timer_watch")
  // (krita-link "/pykrita" "${timer-watch}/pykrita" "timer_watch.desktop");


  home.file = {
    # Firefox userChrome & userContent
    ".mozilla/firefox/${firefox-profile}/chrome" = (
      link "${home-manager}/firefox/chrome");

    # Obsidian CSS
    "${obsidian-dir}/.obsidian/snippets" = (
      link "${home-manager}/obsidian-css");
  };


  # AppImages
  home.packages = [ (appimg.obsidian) ];

  # AppImage desktop entries
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      icon = "obsidian";
      exec = "${appimg.obsidian}/bin/Obsidian %u";
      terminal = false;
    };
  };
}

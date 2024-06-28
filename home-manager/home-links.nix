{ config, pkgs, ... }:
let
  link = src: {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${src}";
  };

  # Directory shorthands
  home-manager = "${config.home.homeDirectory}/NixOS/home-manager";

  ref-tabs = "${home-manager}/krita/reference-tabs-docker";
  comp-helper = "${home-manager}/krita/composition-helper/compositionhelper";
  timer-watch = "${home-manager}/krita/timer-watch";

  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";

  # AppImage packages
  app-icons = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps";

  appimg = {
    obsidian = pkgs.callPackage ../packages/obsidian.nix {
      version = "1.6.3";
      sha256 = "Ed6NWa/wT4kQUV2SjqIdYUL2OXKw2D8OEnk8ZnsKkYQ=";
    };
    krita = pkgs.callPackage ../packages/krita.nix { version = "5.2.2"; };
  };
in
{
  # Symlinks
  # If you're using flakes, use absolute paths or the symlinks will point to the nix store
  # Relative paths can cause broken links, and nothing will update until a rebuild

  # TODO: despite my best efforts at shorthanding, this is still bad.
  # I will work on this again at some point.

  xdg.configFile = {
    "ags" = (link "${home-manager}/ags");
    "dooit/config.py" = (link "${home-manager}/terminal/dooit.py");
    "wlogout/icons" = (link "${home-manager}/hyprland/icons");
  };

  xdg.dataFile = {
    # Krita thumbnails
    "thumbnailers/kra.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
      MimeType=application/x-krita;
    '';

    # Resources (brushes, packs, etc.)
    "krita/Chalks_for_Children.bundle" = (
      link "${home-manager}/krita/Chalks_for_Children.bundle");
    "krita/hollow_line.bundle" = (
      link "${home-manager}/krita/hollow_line.bundle");
    "krita/SK-V1_.bundle" = (
      link "${home-manager}/krita/SK_V1_.bundle");
    "krita/Rakurri_Gradient_Map_Set_V1.0.bundle" = (
      link "${home-manager}/krita/Rakurri_Gradient_Map_Set_V1.0.bundle");

    # Palettes
    "krita/palettes/catppuccin-macchiato.gpl" = (
      link "${home-manager}/krita/gpl-palettes/palettes/catppuccin/catppuccin-macchiato.gpl");
    "krita/palettes/rose-pine-moon.gpl" = (
      link "${home-manager}/krita/gpl-palettes/palettes/rose-pine/rose-pine-moon.gpl");

    # Krita themes
    "krita/color-schemes/CatppuccinMochaMaroon.colors" = (
      link "${home-manager}/krita/CatppuccinMochaMaroon.colors");

    "krita/color-schemes/CatppuccinMacchiatoMaroon.colors" = (
      link "${home-manager}/krita/CatppuccinMacchiatoMaroon.colors");


    # TODO: maybe install krita plugins as packages instead of git checkout?
    
    # Reference Tabs Docker
    "krita/pykrita/reference_tabs" = (
      link "${ref-tabs}/pykrita/reference_tabs");
    "krita/pykrita/reference_tabs.desktop" = (
      link "${ref-tabs}/pykrita/reference_tabs.desktop");

    # Composition helper
    "krita/actions/compositionhelper.action" = (
      link "${comp-helper}/compositionhelper.action");
    "krita/pykrita/compositionhelper" = (
      link "${comp-helper}/compositionhelper");
    "krita/pykrita/compositionhelper.desktop" = (
      link "${comp-helper}/compositionhelper.desktop");

    # Timer Watch
    "krita/pykrita/timer_watch" = (
      link "${timer-watch}/timer_watch");
    "krita/pykrita/timer_watch.desktop" = (
      link "${timer-watch}/timer_watch.desktop");
  };

  home.file = {
    # Firefox userChrome & userContent
    ".mozilla/firefox/${firefox-profile}/chrome" = (
      link "${home-manager}/firefox/chrome");

    # Obsidian CSS
    "${obsidian-dir}/.obsidian/snippets" = (
      link "${home-manager}/obsidian-css");
  };


  # Wrapped in parentheses to prevent each package from
  # being recognized as several elements
  home.packages = [ (appimg.obsidian) (appimg.krita) ];

  # AppImage desktop entries
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

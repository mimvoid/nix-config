{ config, pkgs, ... }:
let
  link = src: {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${src}";
  };
  
  krita-link = target: source: file: {
    "krita${target}/${file}" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${source}/${file}";
    };
  };

  # Directory shorthands
  home-manager = "${config.home.homeDirectory}/NixOS/home-manager";

  krita = "${home-manager}/krita";

  firefox-profile = "30dphuug.default";
  obsidian-dir = "Documents/Zettelkasten";

  # Krita plugin packages
  ref-tabs = pkgs.callPackage ../packages/krita/reference-tabs-docker.nix {};
  comp-helper = pkgs.callPackage ../packages/krita/composition-helper.nix {};
  timer-watch = pkgs.callPackage ../packages/krita/timer-watch.nix {};

  # AppImage packages
  app-icons = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps";

  appimg = {
    obsidian = pkgs.callPackage ../packages/appimages/obsidian.nix {
      version = "1.6.7";
      sha256 = "Bf5IUjM1oX6gGlwXExAdsvEFPYMKXkKLnBFdmhvYCcU=";
    };
    krita = pkgs.callPackage ../packages/appimages/krita.nix {
      version = "5.2.3";
      sha256 = "yRzhgQkxFxwRBU4id8Ie/JfPnXPcOdoSOfbcFGLRnIs=";
    };
  };
in
{
  # Symlinks
  # If you're using flakes, use absolute paths or the symlinks will point to the nix store
  # Relative paths can cause broken links, and nothing will update until a rebuild

  xdg.configFile = {
    "ags" = (link "${home-manager}/ags");
    "dooit/config.py" = (link "${home-manager}/terminal/dooit/config.py");
    "dooit/extra.py" = (link "${home-manager}/terminal/dooit/extra.py");
    "gtk-3.0/gtk.css" = (link "${home-manager}/xfconf/gtk3.css");
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
  }
  # Resources (brushes, packs, etc.)
  // (krita-link "" krita "Chalks_for_Children.bundle")
  // (krita-link "" krita "hollow_line.bundle")
  // (krita-link "" krita "SK_V1_.bundle")
  // (krita-link "" krita "Rakurri_Gradient_Map_Set_V1.0.bundle")

  # Palettes
  // (krita-link
    "/palettes"
    "${krita}/gpl-palettes/palettes/catppuccin"
    "catppuccin-macchiato.gpl")
  // (krita-link
    "/palettes"
    "${krita}/gpl-palettes/palettes/rose-pine"
    "rose-pine-moon.gpl")
  // (krita-link
    "/palettes"
    "${krita}/gpl-palettes/palettes/ayu"
    "ayu-mirage.gpl")

  # Krita themes
  // (krita-link "/color-schemes" krita "CatppuccinMochaMaroon.colors")
  // (krita-link "/color-schemes" krita "CatppuccinMacchiatoMaroon.colors")

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

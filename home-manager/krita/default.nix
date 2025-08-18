{ pkgs, ... }:

{
  imports = [ ./scripts ];

  home.packages = builtins.attrValues {
    inherit (pkgs.voids.krita)
      reference-tabs-docker
      composition-helper
      timer-watch
      shortcut-composer
      ;
    inherit (pkgs.unstable) krita;
  };

  xdg.dataFile = {
    "krita" = {
      source = ./resources;
      recursive = true;
    };

    "krita/color-schemes/CatppuccinMacchiatoMaroon.colors".source = ./CatppuccinMacchiatoMaroon.colors;

    # Krita can't seem to recognize the files in ~/.nix-profile/share/krita/palettes
    "krita/palettes" = {
      source = "${pkgs.voids.gpl-palettes}/share/krita/palettes";
      recursive = true;
    };

    "thumbnailers/kra.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=unzip
      Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
      MimeType=application/x-krita;
    '';
  };
}

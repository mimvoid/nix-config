{ pkgs, ... }:

{
  imports = [ ./scripts ];

  home.packages = builtins.attrValues {
    inherit (pkgs.voids.krita)
      reference-tabs-docker
      composition-helper
      timer-watch
      shortcut-composer
      catppuccin-macchiato-maroon
      ;

    # See https://github.com/NixOS/nixpkgs/issues/509315
    krita = pkgs.symlinkJoin {
      name = "krita-fixed";
      paths = [ pkgs.unstable.krita ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/krita" \
          --prefix XDG_DATA_DIRS : "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}" \
          --prefix XDG_DATA_DIRS : "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      '';
    };
  };

  xdg.dataFile = {
    # Krita has only one resource folder, so simply downloading a package does not make
    # it available to Krita. Therefore, we need to symlink them.
    "krita" = {
      source = "${pkgs.voids.krita.bundles}/share/krita";
      recursive = true;
    };
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

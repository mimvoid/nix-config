{ pkgs }:

{
  catppuccin-macchiato-maroon = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "krita-catppuccin-macchiato-maroon";
    version = "0.2.6";

    src = pkgs.fetchzip {
      url = "https://github.com/catppuccin/kde/releases/download/v${version}/Macchiato-color-schemes.tar.gz";
      sha256 = "1wn7b8k8k3a7jwqsv932drrzj2brgj095kn53659rgyw4iq7kz8a";
    };

    installPhase = ''
      mkdir -p $out/share/krita/color-schemes
      cp CatppuccinMacchiatoMaroon.colors $out/share/krita/color-schemes
    '';
  };

  bundles =
    let
      rakurri = builtins.fetchurl {
        url = "https://github.com/Rakurri/rakurri-gradient-map-set-for-krita/releases/download/V1.0/Rakurri_Gradient_Map_Set_V1.0.bundle";
        sha256 = "1aakvm6hzi652ndv5svv0w9qv2sgzn06ik6m479l5lrv8drbydkz";
      };
      sk-sketching = pkgs.fetchzip {
        url = "https://files.kde.org/krita/extras/SK-V1-Bundle-without-TILT.zip";
        hash = "sha256-J4y3s6R80Dgmc8iuBJlvbUafUF4aFmi7uemOHNpGmJM=";
      };
    in
    pkgs.runCommand "krita-bundles" {  } ''
      mkdir -p $out/share/krita
      cp ${sk-sketching}/SK_V1_.bundle $out/share/krita
      cp ${./Chalks_for_Children.bundle} $out/share/krita/Chalks_for_Children.bundle
      cp ${./hollow_line.bundle} $out/share/hollow_line.bundle
      cp ${rakurri} $out/share/krita/Rakurri_Gradient_Map_Set_V1.0.bundle
    '';
}

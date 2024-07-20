{ stdenvNoCC
, lib
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "major-mono-display";
  version = "unstable-2024-07-20";

  src = fetchFromGitHub {
    owner = "googlefonts";
    repo = "majormono";
    rev = "fae0bb9c728fe082097baedaf23604e290ddac16";
    hash = "sha256-ishGGr8bY6UjEG/Hn5We8hOO5mcDq/41+DMn+dQGGUA=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype fonts/*.ttf 

    runHook postInstall
  '';

  meta = with lib; {
    description = "A monospaced geometric sans serif all-uppercase typeface with a playful attitude";
    longDescription = ''
      Majör is a monospaced geometric sans serif all-uppercase typeface which also has a complete set of constructivist display characters with a playful attitude. It has many Opentype features but the basic variation between serious/playful faces can be implemented on web use where Opentype features can be hard to apply, thanks to the fact that the sans serif and the display versions of the letterforms can be reached via lowercase and uppercase options. This makes Majör a great choice for web typography, especially at large point-sizes.
    '';
    homepage = "https://github.com/googlefonts/majormono";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [];
  };
}

{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation {
  pname = "limelight-font";
  version = "1.002";

  src = fetchzip {
    url = "https://www.1001fonts.com/download/limelight.zip";
    stripRoot = false;
    hash = "sha256-mGKqf7jkgdsEgdeB4ceiOO7ISnkKwF0GkUgd5fwxQY0=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype *.ttf 

    runHook postInstall
  '';

  meta = with lib; {
    description = "A sensitive rendition of the classic high contrast art deco style geometric sans serif";
    longDescription = ''
      Limelight is a sensitive rendition of the classic high contrast
      art deco style geometric sans serif. This style is often used to
      suggest the 1920's time period as well as the theatre generally
      and hollywood filmmaking in particular. Because of the extreme
      contrast of the design it will perform most reliably on web
      pages at medium and large font sizes.
    '';
    homepage = "https://fonts.google.com/specimen/Limelight";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ mimvoid ];
  };
}

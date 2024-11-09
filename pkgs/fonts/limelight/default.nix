{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "limelight-font";
  version = "1.002";

  src = fetchFromGitHub {
    owner = "google";
    repo = "fonts";
    sparseCheckout = [ "ofl/limelight" ];
    rev = "be513c976cb05d66f196b8213a75620fdce1d062";
    hash = "sha256-89NF5U1M/shvfKvmeW8BsAlseGIB5i4YQ2MPqfM1pTE=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype ofl/limelight/*.ttf 

    runHook postInstall
  '';

  meta = {
    description = "Sensitive rendition of the classic high contrast art deco style geometric sans serif";
    longDescription = ''
      Limelight is a sensitive rendition of the classic high contrast
      art deco style geometric sans serif. This style is often used to
      suggest the 1920's time period as well as the theatre generally
      and hollywood filmmaking in particular. Because of the extreme
      contrast of the design it will perform most reliably on web
      pages at medium and large font sizes.
    '';
    homepage = "https://fonts.google.com/specimen/Limelight";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

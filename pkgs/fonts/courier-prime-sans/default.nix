{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "courier-prime-sans";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "quoteunquoteapps";
    repo = "CourierPrimeSans";
    sparseCheckout = [ "ttf" ];
    rev = "5740acaf752618ababc8d0499d225a7dcd3a54a9";
    hash = "sha256-00005U1M/shvfKvmeW8BsAlseGIB5i4YQ2MPqfM1pTE=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype ttf/*.ttf 

    runHook postInstall
  '';

  meta = {
    description = "Sans serif version of Courier Prime";
    homepage = "https://github.com/quoteunquoteapps/CourierPrimeSans";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

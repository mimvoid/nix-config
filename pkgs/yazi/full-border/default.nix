{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "yazi-full-border";
  version = "unstable-2024-12-10";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    sparseCheckout = [ "full-border.yazi" ];
    rev = "ec97f8847feeb0307d240e7dc0f11d2d41ebd99d";
    hash = "sha256-H7seJWTVxYF5of4msnkuZpDnNiROwhS/dtwJJ/GCxGo=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r full-border.yazi/* $out

    runHook postInstall
  '';

  meta = {
    description = "Add a full border to Yazi to make it look fancier";
    homepage = "https://github.com/yazi-rs/plugins";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

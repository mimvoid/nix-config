{ lib, stdenvNoCC, fetchgit }:

stdenvNoCC.mkDerivation {
  pname = "krita-reference-tabs-docker";
  version = "unstable-2024-08-12";

  src = fetchgit {
    url = "https://invent.kde.org/freyalupen/reference-tabs-docker";
    sparseCheckout = [ "pykrita" ];
    rev = "cf6fccd847ec19833ca0a81b2bf58c2fb1d0e231";
    hash = "sha256-hDIAxYVXCV3aW6zwckxkfO9EgLh1S7wdnnw0KDTxHRY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/krita/pykrita
    cp -r pykrita/* $out/share/krita/pykrita

    runHook postInstall
  '';

  meta = {
    description = "Krita plugin with a docker for reference images in separate tabs";
    homepage = "https://invent.kde.org/freyalupen/reference-tabs-docker";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

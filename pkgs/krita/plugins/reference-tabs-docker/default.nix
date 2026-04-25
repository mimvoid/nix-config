{
  lib,
  stdenvNoCC,
  fetchgit,
}:

stdenvNoCC.mkDerivation {
  pname = "krita-reference-tabs-docker";
  version = "unstable-2026-02-15";

  src = fetchgit {
    url = "https://invent.kde.org/freyalupen/reference-tabs-docker";
    rev = "4e9723566c6f6772758067b247b86556a72de242";
    hash = "sha256-L/7tA6o4lrYJZfoiaEsstlP3FQdPkl/QdD+Ihq2kpgk=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/krita
    cp -r pykrita $out/share/krita
    runHook postInstall
  '';

  meta = {
    description = "Krita plugin with a docker for reference images in separate tabs";
    homepage = "https://invent.kde.org/freyalupen/reference-tabs-docker";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

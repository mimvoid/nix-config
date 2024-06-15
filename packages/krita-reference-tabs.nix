{
  lib,
  stdenvNoCC,
  fetchFromGitLab,
}:

# WIP

stdenvNoCC rec {
  pname = "krita-reference-tabs-docker-plugin";
  version = "cf6fccd847ec19833ca0a81b2bf58c2fb1d0e231";

  src = fetchFromGitLab {
    owner = "Freya Lupen";
    repo = "Reference Tabs Docker";
    rev = version;
    hash = "??";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -r src/pykrita/* "$out/"

    runHook postInstall
  '';

  meta = {
    description = "Plugin for Krita: a docker for containing reference images in separate tabs";
    homepage = "https://invent.kde.org/freyalupen/reference-tabs-docker";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [mimvoid];
    platforms = lib.platforms.linux;
  };
}

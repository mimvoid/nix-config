{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "krita-compositionhelper";
  version = "1.2.0";

  src = fetchzip {
    url = "https://codeberg.org/Grum999/CompositionHelper/releases/download/${version}/compositionhelper.zip";
    hash = "sha256-0uIXrd7TATaLjxC0hdaySGgC558z4poIbVJmpTjb03E=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/krita/pykrita $out/share/krita/actions
    cp -t $out/share/krita/pykrita -r compositionhelper.desktop compositionhelper
    cp -r compositionhelper.action $out/share/krita/actions

    runHook postInstall
  '';

  meta = {
    description = "Krita plugin to create layers with common composition helpers";
    homepage = "https://codeberg.org/Grum999/CompositionHelper";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "krita-compositionhelper";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Grum999";
    repo = "CompositionHelper";
    sparseCheckout = [ "compositionhelper" ];
    rev = version;
    hash = "sha256-qBoW+onNmW6VCNVIQBQcKQDIxltWXUzfeJu9Lbcw8wE=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/krita/pykrita $out/share/krita/actions

    cd compositionhelper
    cp -t $out/share/krita/pykrita -r compositionhelper.desktop compositionhelper
    cp -r compositionhelper.action $out/share/krita/actions

    runHook postInstall
  '';

  meta = {
    description = "Krita plugin to create layers with common composition helpers";
    homepage = "https://github.com/Grum999/CompositionHelper";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

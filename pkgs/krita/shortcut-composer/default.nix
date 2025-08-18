{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "krita-shortcut-composer";
  version = "1.5.4";

  src = fetchFromGitHub {
    owner = "wojtryb";
    repo = "Shortcut-Composer";
    sparseCheckout = [
      "shortcut_composer.desktop"
      "shortcut_composer"
    ];
    rev = "v${version}";
    hash = "sha256-TCuBLaIENOrYQP8e+Qq3AJweiiWoRkgOBoGcUjAZa5I=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/krita/pykrita
    cp -t $out/share/krita/pykrita -r shortcut_composer.desktop shortcut_composer

    runHook postInstall
  '';

  meta = {
    description = " Krita plugin for creating complex keyboard shortcuts ";
    homepage = "https://github.com/wojtryb/Shortcut-Composer";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers =  [ lib.maintainers.mimvoid ];
  };
}

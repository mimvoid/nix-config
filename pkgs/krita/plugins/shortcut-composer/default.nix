{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "krita-shortcut-composer";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "wojtryb";
    repo = "Shortcut-Composer";
    rev = "v${version}";
    hash = "sha256-G/Aos9tE8ssg1sUdZEjWvdeV2joS63Sf25RdbizVKjE=";
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
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

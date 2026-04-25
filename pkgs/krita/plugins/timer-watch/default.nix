{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "krita-timer-watch";
  version = "unstable-2025-01-06";

  src = fetchFromGitHub {
    owner = "EyeOdin";
    repo = "timer_watch";
    rev = "d9f5dd6afba5e80cbfdb3026076c93da5db87c89";
    hash = "sha256-htigJ+QT5E9csm7K7HxFbcndbUsOAsQ2MkX7qwh/coU=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/krita/pykrita
    cp -t $out/share/krita/pykrita -r timer_watch.desktop timer_watch
    runHook postInstall
  '';

  meta = {
    description = "Krita plugin and time management tool";
    homepage = "https://github.com/EyeOdin/timer_watch";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

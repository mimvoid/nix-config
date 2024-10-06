{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "krita-timer-watch";
  version = "unstable-2024-08-12";

  src = fetchFromGitHub {
    owner = "EyeOdin";
    repo = "timer_watch";
    sparseCheckout = [
      "timer_watch.desktop"
      "timer_watch/__init__.py"
      "timer_watch/timer_watch_docker.py"
      "timer_watch/timer_watch_docker.ui"
      "timer_watch/timer_watch_settings.ui"
    ];
    rev = "1f181c8bdf5a4410b4c43537910f0e1d36ed95d8";
    hash = "sha256-aIzB+nYmwKX2oiUmaHLWwEZz+RIyhaCaXndrax8MzCI=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/krita/pykrita
    cp -r * $out/share/krita/pykrita

    runHook postInstall
  '';

  meta = {
    description = "Krita plugin and time management tool";
    homepage = "https://github.com/EyeOdin/timer_watch";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

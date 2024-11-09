{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "yazi-exifaudio";
  version = "unstable-2024-09-02";

  src = fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "6205460405fa39c017d0eef12997c1180658e695";
    hash = "sha256-mYvq7xnd4gI0KoG5G+ygDxqCWdpZbMn3Im1EiW3eSyI=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out

    runHook postInstall
  '';

  meta = {
    description = "Preview audio metadata and cover in Yazi";
    homepage = "https://github.com/Sonico98/exifaudio.yazi";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

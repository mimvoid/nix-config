{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "ma-shan-zheng";
  version = "2.001";

  src = fetchFromGitHub {
    owner = "m4rc1e";
    repo = "mashanzheng";
    rev = "fb124f9b3246a54a934d6ce6deba36c0bd2e2812";
    hash = "sha256-AnP+S/0y/O93qP/recjrW5AV5qJKPZfEIiPIC+QWOQ8=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype fonts/*.ttf 

    runHook postInstall
  '';

  meta = {
    description = "Script reminiscent of fonts used to display 'yinglian'";
    longDescription = ''
      This script is reminiscent of fonts used to display "yinglian,"
      the short poems and blessings traditionally posted on either
      side of the entryway to a home or temple. MaShanZheng is heavy
      and majestic, vital and expansive. 
    '';
    homepage = "https://fonts.google.com/specimen/Ma+Shan+Zheng";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

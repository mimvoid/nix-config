{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation {
  pname = "ritzflf";
  version = "2024-12-25";

  src = fetchzip {
    url = "https://moorstation.org/typoasis/designers/casady_greene/r-z/Ritz.zip";
    hash = "sha256-V6NYAg+7GLB7H/dip1vmZVfszc0xjiAzis1LOFZ9vyA=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype *.ttf

    runHook postInstall
  '';

  meta = {
    description = "Bold geometric font with art deco influences";
    homepage = "https://moorstation.org/typoasis/designers/casady_greene/r_z.htm";
    license = lib.licenses.free;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "ritzflf";
  version = "2025-08-14";

  src = fetchFromGitHub {
    owner = "mimvoid";
    repo = "casady-greene";
    sparseCheckout = [ "fonts/ritz/ttf" ];
    rev = "25f84eee481cff1e624247f000300bf0f70c19da";
    hash = "sha256-4pZg2RqI7O8wlC6dxVMiYxjiK6ztVOz+i6r4Nk/jazw=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/truetype fonts/ritz/ttf/*.ttf

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

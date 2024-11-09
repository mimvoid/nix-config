{
  lib,
  stdenv,
  fetchFromGitHub,
  bdf2psf,
}:

stdenv.mkDerivation {
  pname = "leggie";
  version = "3.2";

  src = fetchFromGitHub {
    owner = "wikkyk";
    repo = "leggie";
    rev = "05aeb2867ade1fce43bb49aa78c76fae7fc9fd76";
    hash = "sha256-TELw+cbbSQy5OS/6d6PFtTZveg69ZdXihiBMgmxW81E=";
  };

  nativeBuildInputs = [ bdf2psf ];

  postPatch = ''
    substituteInPlace Makefile --replace "/usr/share/fonts" "$out/share/fonts"
    substituteInPlace Makefile --replace "/usr/share/consolefonts" "$out/share/consolefonts"
    substituteInPlace Makefile --replace 'gzip' 'gzip -n -f'
  '';

  installTargets = [ "install" ];

  meta = {
    description = "Pretty, legible bitmap font with over 1700 glyphs";
    longDescription = ''
      Leggie is a pleasant, legible monospaced (character cell) bitmap font.
      It was designed for readability and long work in a terminal.
      It's one of the very few sans-serif monospace fonts.
    '';
    homepage = "https://github.com/wikkyk/leggie";
    license = lib.licenses.cc-by-40;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

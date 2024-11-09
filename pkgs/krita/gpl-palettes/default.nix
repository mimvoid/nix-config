{ lib,
  stdenvNoCC,
  fetchFromGitHub,
  palettes ? []
}:
# There's probably a better way to fetch specific files
# But this works for now
let
  paletteList = builtins.toString (
    builtins.map (i: "'${i}'") palettes
  );
in
stdenvNoCC.mkDerivation {
  pname = "gpl-palettes";
  version = "unstable-2024-07-04";

  src = fetchFromGitHub {
    owner = "mimvoid";
    repo = "gpl-palettes";
    sparseCheckout = [ "palettes" ];
    rev = "1c3afb84c4a8564ed234a6ce37a0cff118a4938b";
    hash = "sha256-1o1kBW18EK94cJKl2ijWzvvKe1Teoyk0wl+KVpCUvGQ=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/krita/palettes

    palettes=(${paletteList})
    for n in "''${palettes[@]}"; do
      cp -r palettes/*/"''${n}".gpl $out/share/krita/palettes
    done

    runHook postInstall
  '';

  meta = {
    description = "Collection of .gpl palettes";
    homepage = "https://github.com/mimvoid/gpl-palettes";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

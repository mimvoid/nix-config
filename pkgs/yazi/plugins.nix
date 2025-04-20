{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "yazi-plugins";
  version = "unstable-2025-03-23";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "b12a9ab085a8c2fe2b921e1547ee667b714185f9";
    hash = "sha256-LWN0riaUazQl3llTNNUMktG+7GLAHaG/IxNj1gFhDRE=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    mkdir -p $out/full-border.yazi
    cp -r full-border.yazi/main.lua $out/full-border.yazi

    mkdir -p $out/git.yazi
    cp -r git.yazi/main.lua $out/git.yazi

    mkdir -p $out/max-preview.yazi
    cp -r max-preview.yazi/main.lua $out/max-preview.yazi

    runHook postInstall
  '';

  meta = {
    description = "Plugins for Yazi";
    homepage = "https://github.com/yazi-rs/plugins";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

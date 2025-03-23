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
    rev = "273019910c1111a388dd20e057606016f4bd0d17";
    hash = "sha256-80mR86UWgD11XuzpVNn56fmGRkvj0af2cFaZkU8M31I=";
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

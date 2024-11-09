{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "yazi-bookmarks";
  version = "unstable-2024-09-02";

  src = fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "ae06e0c1c02f42ad4ec57073f579d7204d2ca563";
    hash = "sha256-f1+ANWYw//cU+icLFgtFS9/DrSNIIGTkkXPMQ6zWfT4=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out

    runHook postInstall
  '';

  meta = {
    description = "Yazi plugin that adds the basic functionality of vi-like marks";
    homepage = "https://github.com/dedukun/bookmarks.yazi";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

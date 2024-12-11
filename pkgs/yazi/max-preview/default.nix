{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "yazi-max-preview";
  version = "unstable-2024-12-10";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    sparseCheckout = [ "max-preview.yazi" ];
    rev = "ec97f8847feeb0307d240e7dc0f11d2d41ebd99d";
    hash = "sha256-P17dq9CsOweQcwxgyHTf2LQ4yiOFm6Ikb6m9f/FBDgs=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r max-preview.yazi/* $out

    runHook postInstall
  '';

  meta = {
    description = "Maximize or restore the preview pane in Yazi";
    homepage = "https://github.com/yazi-rs/plugins";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

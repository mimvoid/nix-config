{
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "yazi-git";
  version = "unstable-2024-12-09";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    sparseCheckout = [ "git.yazi" ];
    rev = "ec97f8847feeb0307d240e7dc0f11d2d41ebd99d";
    hash = "sha256-30oi+19Ij1mezKWk8dInGxZbFaWneyAtQ5aOAl+jsm8=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r git.yazi/* $out

    runHook postInstall
  '';
}

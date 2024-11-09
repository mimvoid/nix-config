{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "yazi-full-border";
  version = "unstable-2024-08-12";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    sparseCheckout = [ "full-border.yazi" ];
    rev = "2dc65ab07d85c3a63e663eeade1324438dc83942";
    hash = "sha256-OP8HnD7NbwOruubgZXod8R3HJJeNhYub8MCsPljuclI=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r full-border.yazi/* $out

    runHook postInstall
  '';

  meta = {
    description = "Add a full border to Yazi to make it look fancier.";
    homepage = "https://github.com/yazi-rs/plugins";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

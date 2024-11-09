{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "yazi-max-preview";
  version = "unstable-2024-08-12";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    sparseCheckout = [ "max-preview.yazi" ];
    rev = "2dc65ab07d85c3a63e663eeade1324438dc83942";
    hash = "sha256-xZJr9kFd4Ma7NXxE9a1yeb7uKqoilmvn+1bszLXvsk0=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r max-preview.yazi/* $out

    runHook postInstall
  '';

  meta = {
    description = "Maximize or restore the preview pane in Yazi.";
    homepage = "https://github.com/yazi-rs/plugins";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

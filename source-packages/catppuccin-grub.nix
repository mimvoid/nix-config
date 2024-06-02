{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  flavor ? "mocha", # override with your chosen flavor
  ...
}:

stdenvNoCC.mkDerivation {
  pname = "catppuccin-grub";
  version = "1.0.0";

  src = fetchFromGitHub rec {
    owner = "catppuccin";
    repo = "grub";
    rev = "refs/tags/v${version}";
    hash = "sha256-e8XFWebd/GyX44WQI06Cx6sOduCZc5z7/YhweVQGMGY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -r ${src}/src/catppuccin-${flavor}-grub-theme/* "$out"/

    runHook postInstall
  '';

  meta = {
    description = "Soothing pastel theme for GRUB";
    homepage = "https://github.com/catppuccin/grub";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    platforms = lib.platforms.linux;
  };
}

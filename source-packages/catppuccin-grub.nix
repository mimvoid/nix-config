{
  lib,
  stdenv,
  fetchFromGitHub,
  flavor ? "mocha", # override with your chosen flavor
  ...
}:

stdenv.mkDerivation {
  pname = "catppuccin-grub";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "88f6124757331fd3a37c8a69473021389b7663ad";
    hash = "sha256-e8XFWebd/GyX44WQI06Cx6sOduCZc5z7/YhweVQGMGY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -r ${sources.grub}/src/catppuccin-${flavor}-grub-theme/* "$out"/

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

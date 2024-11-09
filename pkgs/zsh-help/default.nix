{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:

stdenvNoCC.mkDerivation {
  pname = "zsh-help";
  version = "unstable-2024-11-03";

  src = fetchFromGitHub {
    owner = "Freed-Wu";
    repo = "zsh-help";
    sparseCheckout = [ "zsh-help.plugin.zsh" ];
    rev = "95cbc114078d8209730e38c72a6fa5859ca0773d";
    hash = "sha256-ij+ooXQxV3CmsCN/CrJMicTWvS+9GYHA/1Kuqh5zXIY=";
  };

  strictDeps = true;
  dontBuild = true;

  # Re-enable bat's automatic pager
  installPhase = ''
    mkdir -p $out
    cp -r zsh-help.plugin.zsh $out
    substituteInPlace $out/zsh-help.plugin.zsh \
      --replace '-pplhelp' '-plhelp'
  '';

  meta = {
    description = "zsh plugin to colorize `XXX --help`";
    homepage = "https://github.com/Freed-Wu/zsh-help";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}

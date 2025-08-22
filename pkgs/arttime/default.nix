{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installShellFiles,
  zsh,
  withLibnotify ? true,
  withVorbistools ? true,
  withFzf ? true,
  libnotify,
  vorbis-tools,
  fzf,
}:

stdenvNoCC.mkDerivation rec {
  pname = "arttime";
  version = "2.3.4";

  src = fetchFromGitHub {
    owner = "poetaman";
    repo = "arttime";
    rev = "v${version}";
    hash = "sha256-hYC9om8141Z+PbJGU4d63Y0Up4kkYslPr3CO5KuwNTc=";
  };

  nativeBuildInputs = [
    zsh
    installShellFiles
  ];

  buildInputs =
    [ ]
    ++ lib.optionals withLibnotify [ libnotify ]
    ++ lib.optionals withVorbistools [ vorbis-tools ]
    ++ lib.optionals withFzf [ fzf ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin \
      $out/share/arttime/doc \
      $out/share/arttime/keypoems \
      $out/share/arttime/src \
      $out/share/arttime/textart \
      $out/share/man/man1

    zsh ./install.sh --prefix $out --zcompdir - --noupdaterc

    runHook postInstall
  '';

  postInstall = ''
    installShellCompletion --zsh --name _artprint share/zsh/functions/_artprint
    installShellCompletion --zsh --name _arttime share/zsh/functions/_arttime
  '';

  meta = {
    description = "Clock, timer, time manager and ASCII+ text-art viewer for the terminal";
    longDescription = ''
      Text art meets the functionality of a feature-rich clock/timer/pattern-based
      time manager. Arttime brings curated text art to otherwise artless terminal
      emulators of starving developers and other users who can use the terminal.
    '';
    homepage = "https://github.com/poetaman/arttime";
    license = [ lib.licenses.gpl3Only ];
    platforms = lib.platforms.all;
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

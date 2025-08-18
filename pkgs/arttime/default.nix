{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installShellFiles,
  zsh,
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

  nativeBuildInputs = [ installShellFiles ];
  buildInputs = [
    zsh
    libnotify
    vorbis-tools
    fzf
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share

    cp -a bin $out
    cp -a share/arttime $out/share

    runHook postInstall
  '';

  postInstall = ''
    installManPage share/man/man1/*
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
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.mimvoid ];
  };
}

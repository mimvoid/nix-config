{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installShellFiles,
  zsh,
  coreutils,
  gnused,
  withLibnotify ? true,
  withVorbistools ? true,
  withFzf ? true,
  libnotify,
  vorbis-tools,
  fzf,
}:

stdenvNoCC.mkDerivation rec {
  pname = "arttime";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "poetaman";
    repo = "arttime";
    rev = "v${version}";
    hash = "sha256-luz2tz8ammN4Xiw5q4vUVAAwIpbDNU/vO/ewTlvjRHA=";
  };

  nativeBuildInputs = [
    zsh
    installShellFiles
  ];

  buildInputs = [
    gnused
  ]
  ++ lib.optionals withLibnotify [ libnotify ]
  ++ lib.optionals withVorbistools [ vorbis-tools ]
  ++ lib.optionals withFzf [ fzf ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    substituteInPlace install.sh \
      --replace-fail "/bin/mkdir" "${coreutils}/bin/mkdir"

    zsh ./install.sh --prefix $out --zcompdir - --noupdaterc

    runHook postInstall
  '';

  postInstall = ''
    installShellCompletion --zsh --name _artprint share/zsh/functions/_artprint
    installShellCompletion --zsh --name _arttime share/zsh/functions/_arttime

    substituteInPlace $out/share/arttime/src/arttime.zsh \
      --replace-warn "/bin/stty" "${coreutils}/bin/stty"
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

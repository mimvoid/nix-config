{
  stdenvNoCC,
  fetchurl,
  appimageTools,
  makeWrapper,
  electron,
}:

stdenvNoCC.mkDerivation rec {
  pname = "freetube";
  version = "0.23.5";

  src = fetchurl {
    url = "https://github.com/FreeTubeApp/FreeTube/releases/download/v${version}-beta/freetube-${version}-amd64.AppImage";
    hash = "sha256-qARg6D33lbxPCDbc4ehl3d5sbxzeJO0Q/j2nxnb+hw8=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/${pname} $out/share/applications

    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/freetube.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar
  '';
}

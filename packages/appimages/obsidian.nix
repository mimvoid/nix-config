{ stdenvNoCC,
  lib,
  fetchurl,
  appimageTools,
  makeWrapper,
  electron
}:

stdenvNoCC.mkDerivation rec {
  pname = "obsidian";
  version = "1.6.7";

  src = fetchurl {
    name = "${pname}-${version}.AppImage";
    url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/Obsidian-${version}.AppImage";
    hash = "sha256-Bf5IUjM1oX6gGlwXExAdsvEFPYMKXkKLnBFdmhvYCcU=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/${pname} $out/share/applications

    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/obsidian.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar
  '';

  meta = {
    description = "A powerful knowledge base that works on top of a local folder of plain text Markdown files";
    homepage = "https://obsidian.md";

    # Not true, I just don't want to bother adding it to my unfree packages list
    license = lib.licenses.free;

    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mimvoid ];
    mainProgram = "obsidian";
  };
}

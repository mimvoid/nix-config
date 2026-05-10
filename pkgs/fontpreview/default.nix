{
  stdenvNoCC,
  lib,
  fetchFromGitHub,
  makeWrapper,
  xdotool,
  fzf,
  imagemagick,
  nsxiv,
}:

stdenvNoCC.mkDerivation rec {
  pname = "fontpreview";
  version = "unstable-2024-12-25";

  src = fetchFromGitHub {
    owner = "sdushantha";
    repo = pname;
    rev = "82533a6d76310737fcecf4694067ff5df5a5fc58";
    hash = "sha256-Wpad76UR1hQRypV1MhvttedUCH0lwAM1QddelBBPcHI=";
  };

  nativeBuildInputs = [ makeWrapper ];

  preInstall = "mkdir -p $out/bin";

  installFlags = [ "PREFIX=$(out)" ];

  postInstall = ''
    wrapProgram $out/bin/fontpreview \
      --prefix PATH : ${
        lib.makeBinPath [
          xdotool
          fzf
          imagemagick
          nsxiv
        ]
      } \
      --suffix FONTPREVIEW_SIZE : "650x700" \
      --suffix FONTPREVIEW_PREVIEW_TEXT : "${
        builtins.concatStringsSep "\n" [
          "SPHINX OF BLACK QUARTZ,"
          "JUDGE MY VOW."
          "" # extra line break
          "Sphinx of Black Quartz,"
          "Judge My Vow."
          ""
          "sphinx of black quartz,"
          "judge my vow."
          ""
          "1234567890"
          ''!@$\%(){}[];:\'\"''
        ]
      }"
  '';

  meta = {
    homepage = "https://github.com/sdushantha/fontpreview";
    description = "Highly customizable and minimal font previewer written in bash";
    longDescription = ''
      fontpreview is a commandline tool that lets you quickly search for fonts
      that are installed on your machine and preview them. The fuzzy search
      feature is provided by fzf and the preview is generated with imagemagick
      and then displayed using sxiv. This tool is highly customizable, almost
      all of the variables in this tool can be changed using the commandline
      flags or you can configure them using environment variables.
    '';
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ erictapen ];
    mainProgram = "fontpreview";
  };
}

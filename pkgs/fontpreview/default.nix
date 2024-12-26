{
  stdenv,
  lib,
  fetchFromGitHub,
  makeWrapper,
  xdotool,
  fzf,
  imagemagick,
  nsxiv,
}:

stdenv.mkDerivation rec {
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
      }
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

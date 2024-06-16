{ appimageTools,
  fetchurl,
  version ? "1.6.3",
  sha256 ? "0ea46f42321310425f2a5589231a1fcc55b1f00df41d70af5afa726aaeab8c12"
}:
let
  pname = "Obsidian";
  src = fetchurl {
    url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/Obsidian-${version}.AppImage";
    inherit sha256;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}

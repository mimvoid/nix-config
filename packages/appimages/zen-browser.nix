{ appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "zen-browser";
  version = "1.0.0-a.29";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-specific.AppImage";
    hash = "sha256-cB2aJ9awl+gTyBOe0T7wMiZWw7RcwohOuCCdWBJXXwo=";
  };
}

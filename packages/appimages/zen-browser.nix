{ appimageTools,
  fetchurl,
  version ? "1.0.0-a.29",
  hash ? "sha256-cB2aJ9awl+gTyBOe0T7wMiZWw7RcwohOuCCdWBJXXwo="
}:
let
  pname = "zen-browser";
  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-specific.AppImage";
    inherit hash;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}

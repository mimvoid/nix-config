{ appimageTools,
  fetchurl,
  version ? "5.2.2",
  sha256 ? "b69297bcbf916595c14e8585e2dc9fea35c992b416d721d3bdb5558de2405be0"
}:
let
  pname = "krita";
  src = fetchurl {
    url = "https://download.kde.org/stable/krita/${version}/krita-${version}-x86_64.appimage";
    inherit sha256;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}

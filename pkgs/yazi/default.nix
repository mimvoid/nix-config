{ pkgs, ... }:

with pkgs;
{
  bookmarks = fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "20ece7e1ef3c8180f199cc311f187b662662bc87";
    hash = "sha256-CpoHpYAeMuSn5Sfaq30vzTj/ukrUjtXI0zZioJLnWqw=";
  };

  exifaudio = fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "d7946141c87a23dcc6fb3b2730a287faf3154593";
    hash = "sha256-nXBxPG6PVi5vstvVMn8dtnelfCa329CTIOCdXruOxT4=";
  };

  full-border = callPackage ./full-border { };
  git = callPackage ./git { };
  max-preview = callPackage ./max-preview { };
}

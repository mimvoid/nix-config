{ pkgs, ... }:

with pkgs;
{
  bookmarks = callPackage ./bookmarks { };
  exifaudio = callPackage ./exifaudio { };
  full-border = callPackage ./full-border { };
  max-preview = callPackage ./max-preview { };
}

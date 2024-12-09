{ pkgs, ... }:

with pkgs;
{
  bookmarks = fetchFromGitHub {
    owner = "dedukun";
    repo = "bookmarks.yazi";
    rev = "ae06e0c1c02f42ad4ec57073f579d7204d2ca563";
    hash = "sha256-f1+ANWYw//cU+icLFgtFS9/DrSNIIGTkkXPMQ6zWfT4=";
  };

  exifaudio = fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "6205460405fa39c017d0eef12997c1180658e695";
    hash = "sha256-mYvq7xnd4gI0KoG5G+ygDxqCWdpZbMn3Im1EiW3eSyI=";
  };

  full-border = callPackage ./full-border { };
  max-preview = callPackage ./max-preview { };
}

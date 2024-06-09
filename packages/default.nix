let 
  pkgs = import <nixpkgs> {};
in {
  obsidian = pkgs.callPackage ./obsidian.nix { version = "1.6.3"; };
  krita = pkgs.callPackage ./krita.nix { version = "5.2.2"; };
}

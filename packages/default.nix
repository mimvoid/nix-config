let 
  pkgs = import <nixpkgs> {};
in {
  obsidian = pkgs.callPackage ./obsidian.nix {};
}

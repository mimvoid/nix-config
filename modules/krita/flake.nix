{
  # WIP

  description = "A free and open source painting application";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, }:
  let
    version = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./version);
    genSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in
  {
    packages = genSystems (system: rec {
      default = pkgs.${system}.callPackage ./nix {inherit version;};
      krita = default;
      kritaWithTypes = default; # for backwards compatibility
      kritaNoTypes = pkgs.${system}.callPackage ./nix {
        inherit version;
        buildTypes = false;
      };
    });

    homeManagerModules.default = import ./nix/hm-module.nix self;
  };
}

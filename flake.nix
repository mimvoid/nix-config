{
  description = "mimvoid's NixOS system & home flake configuration";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-26.05";
    nixpkgs-unstable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "github:mimvoid/neovim-dots";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # My fetcher
    fletchling = {
      url = "github:mimvoid/fletchling";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = import ./overlays { inherit inputs; };
        config.allowUnfree = true;
      };

      allSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
      toSystems = passPkgs: allSystems (system: passPkgs (import nixpkgs { inherit system; }));

      modules = import ./modules { inherit (pkgs) lib; };
    in
    {
      inherit (modules) nixosModules;
      packages = toSystems (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations.sirru = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/sirru ];
      };

      nixosConfigurations.auriga = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/auriga ];
      };

      nixosConfigurations.customIso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/iso ];
      };

      homeConfigurations.zinnia = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/home.nix
          ./modules/home-manager/voids.nix
          {
            # Directory for absolute paths, use sparingly
            voids.flakeDir = "/home/zinnia/NixOS";
          }
        ];
      };
    };
}

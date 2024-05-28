 {
    description = "NixOS & Home Manager flake configuration";

    inputs = {
        # Nix packages
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

        # Home Manager & modules
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix/master";
        plasma-manager = {
            url = "github:pjones/plasma-manager/trunk";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
    };

    outputs = inputs @ { self, nixpkgs, home-manager, nixvim, stylix, plasma-manager, ... }:
    {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [ ./configuration.nix ];
            };
        };
        homeConfigurations = {
            "zinnia" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                extraSpecialArgs = { inherit inputs; };
                modules = [
                    ./home-manager/home.nix
                    stylix.homeManagerModules.stylix
                    nixvim.homeManagerModules.nixvim
                    plasma-manager.homeManagerModules.plasma-manager
                ];
            };
        };
    };
 }

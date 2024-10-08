{
  description = "NixOS & Home Manager flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extra modules
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/master";

    ags.url = "github:Aylur/ags/v2";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    stylix,
    ... } @ inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      
      # Allows nixpkgs-unstable to be referenced with pkgs.unstable.<package>
      overlays = [
        (final: _prev: {
          unstable = import nixpkgs-unstable {
            system = final.system;
          };
        })
      ];
    };

    allow-unfree = [ "" ];
  in
  {
    nixosConfigurations = {
      sirru = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs allow-unfree; };
        modules = [
          ./configuration.nix
          ./hosts/sirru/hardware-configuration.nix
        ];
      };

      customIso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/iso/configuration.nix ];
      };
    };
    
    homeConfigurations = {
      "zinnia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs allow-unfree; };
        modules = [
          ./home-manager/home.nix
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}

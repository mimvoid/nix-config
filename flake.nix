{
  description = "NixOS & Home Manager flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    # Extra modules
    ags.url = "github:Aylur/ags";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    nix-colors,
    stylix,
    ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      
      # Allows nixpkgs-unstable to be referenced with pkgs.unstable.<package>
      overlays = [
        (self: super: {
          unstable = import nixpkgs-unstable {
            system = self.system;
          };
        })
      ];
    };
    allowed-unfree-packages = [ "zoom" ];
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs allowed-unfree-packages; };
        modules = [ ./configuration.nix ];
      };

      customIso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/iso/configuration.nix ];
      };
    };
    
    homeConfigurations = {
      "zinnia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs allowed-unfree-packages; };
        modules = [
          ./home-manager/home.nix
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}

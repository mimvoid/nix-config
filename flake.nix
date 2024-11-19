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

    # My Neovim
    nvim = {
      url = "github:mimvoid/neovim-dots";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Extra modules
    stylix = {
      url = "github:danth/stylix/master";
      inputs = {
        base16-fish.follows = "";
        base16-helix.follows = "";
        gnome-shell.follows = "";
        tinted-foot.follows = "";
        tinted-tmux.follows = "";
      };
    };

    ags.url = "github:Aylur/ags/v2";

    dooit.url = "github:dooit-org/dooit";
    dooit-extras.url = "github:dooit-org/dooit-extras";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    stylix,
    ...
  } @ inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      # Allows certain unfree packages
      config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "vivaldi"
        "obsidian"
      ];

      # Allows nixpkgs-unstable to be referenced with pkgs.unstable.<package>
      overlays = [
        (final: _prev: {
          unstable = import nixpkgs-unstable {
            system = final.system;
            config.allowUnfreePredicate = final.config.allowUnfreePredicate;
          };
        })
      ];
    };

    FLAKE = "/home/zinnia/NixOS";
  in
  {
    nixosConfigurations = {
      sirru = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hosts/sirru/hardware-configuration.nix

          { environment.variables = { inherit FLAKE; }; }
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
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/home.nix
          stylix.homeManagerModules.stylix

          { home.sessionVariables = { inherit FLAKE; }; }
        ];
      };
    };
  };
}

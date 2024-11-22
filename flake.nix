{
  description = "mimvoid's NixOS system & home flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Neovim
    # Local repo from $ nix registry add flake:neovim-dots git+file:///path/to/neovim-dots
    # Remote is github:mimvoid/neovim-dots
    nvim = {
      url = "flake:neovim-dots";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix = {
      url = "github:danth/stylix/master";
      inputs = {
        # Ignore un-needed inputs
        base16-fish.follows = "";
        base16-helix.follows = "";
        gnome-shell.follows = "";
        tinted-foot.follows = "";
        tinted-tmux.follows = "";
      };
    };

    # Extra packages
    ags.url = "github:Aylur/ags";

    # Dooit v3
    dooit.url = "github:dooit-org/dooit";
    dooit-extras.url = "github:dooit-org/dooit-extras";

    # Submodules, to call otherwise untracked files
    # Can use "${inputs.<submodule>.outPath}/<file-in-submodule>"
    wallpapers = {
      url = "git+file:wallpapers"; # relative path ./wallpapers
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = import ./overlays { inherit inputs; };

      # Allow certain unfree packages
      config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "vivaldi"
        "obsidian"
      ];
    };

    # Directory for absolute paths, use sparingly
    FLAKE = "/home/zinnia/NixOS";
  in
  {
    nixosConfigurations = {
      sirru = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
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
          inputs.stylix.homeManagerModules.stylix

          { home.sessionVariables = { inherit FLAKE; }; }
        ];
      };
    };
  };
}

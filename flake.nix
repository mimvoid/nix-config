{
  description = "mimvoid's NixOS system & home flake configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-25.05";
    nixpkgs-unstable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";

        # Ignore un-needed inputs
        base16-fish.follows = "";
        base16-helix.follows = "";
        base16-vim.follows = "";
        gnome-shell.follows = "";
        tinted-foot.follows = "";
        tinted-kitty.follows = "";
        tinted-tmux.follows = "";
        firefox-gnome-theme.follows = "";
      };
    };

    # Extra packages
    ags.url = "github:Aylur/ags";

    # Dooit v3
    dooit.url = "github:dooit-org/dooit";
    dooit-extras.url = "github:dooit-org/dooit-extras";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
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
    flakePath = "/home/zinnia/NixOS";
  in
  {
    nixosConfigurations = {
      sirru = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hosts/intel.nix
          ./hosts/sirru/hardware-configuration.nix
          ./hosts/sirru/extra.nix
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
        extraSpecialArgs = {
          inherit inputs;
          inherit flakePath;
        };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}

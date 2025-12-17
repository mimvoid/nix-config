{
  description = "mimvoid's NixOS system & home flake configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-25.11";
    nixpkgs-unstable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      url = "github:nix-community/stylix/release-25.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";

        # Ignore un-needed inputs
        base16-fish.follows = "";
        base16-helix.follows = "";
        base16-vim.follows = "";
        firefox-gnome-theme.follows = "";
        gnome-shell.follows = "";
        nur.follows = "";
        tinted-foot.follows = "";
        tinted-kitty.follows = "";
        tinted-schemes.follows = "";
        tinted-tmux.follows = "";
        tinted-zed.follows = "";
      };
    };

    # Extra packages
    ags.url = "github:Aylur/ags";
    # aagl.url = "github:ezKEa/aagl-gtk-on-nix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = import ./overlays { inherit inputs; };

        # Allow certain unfree packages
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "arttime"
            "vivaldi"
            "obsidian"
            "steam"
            "steam-unwrapped"
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
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home-manager/home.nix
            (import ./modules/hm.nix { inherit flakePath; })
          ];
        };
      };
    };
}

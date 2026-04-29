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
        config.allowUnfree = true;
      };

      allSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
      toSystems = passPkgs: allSystems (system: passPkgs (import nixpkgs { inherit system; }));

      # Directory for absolute paths, use sparingly
      flakeDir = "/home/zinnia/NixOS";

      # Basic function to create an attrset of files and their content from a directory.
      import-modules-dir =
        dir:
        pkgs.lib.attrsets.mapAttrs' (name: value: {
          name = pkgs.lib.strings.removeSuffix ".nix" name;
          value = import "${dir}/${name}";
        }) (builtins.readDir dir);
    in
    {
      nixosModules = import-modules-dir ./modules/nixos;
      packages = toSystems (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations.sirru = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/sirru ];
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
          { voids = { inherit flakeDir; }; }
        ];
      };
    };
}

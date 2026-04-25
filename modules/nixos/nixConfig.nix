{ inputs, pkgs, ... }:

{
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
    "nixpkgs-unstable=${inputs.nixpkgs-unstable}"
  ];

  nix.settings = {
    # No dirty Git tree reminders on rebuild.
    allow-dirty = true;
    warn-dirty = false;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    auto-optimise-store = true;

    # Binary caches from cachix
    substituters = [ "https://mimvoid.cachix.org" ];
    trusted-public-keys = [ "mimvoid.cachix.org-1:c1LQSKRAc7IiFA8GuaTDzD4fqUIG49Cftb2aJwqvtzY=" ];
    trusted-users = [ "root" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Basic packages for working with Nix.
  environment.systemPackages = [
    pkgs.nh
    pkgs.git
  ];
}

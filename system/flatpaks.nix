{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak.enable = true;

  # Managed by nix-flatpak
  services.flatpak = {
    uninstallUnmanaged = false;

    # Mostly just runtimes
    packages = [
      # GNOME runtime
      "org.gnome.Platform//45" # for aagl
    ];
  };
}

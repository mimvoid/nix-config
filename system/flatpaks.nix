{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  
  services.flatpak.enable = true;

  # Managed by nix-flatpak
  services.flatpak = {
    uninstallUnmanaged = false;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    # Mostly just runtimes
    packages = [
      # GNOME runtime
      "org.gnome.Platform//45" # for aagl
      "org.gnome.Platform//46"
    ];
  };
}

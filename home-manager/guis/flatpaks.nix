{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  # Enable nix-flatpak
  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
    {
      name = "launcher.moe";
      location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
    }
  ];

  services.flatpak.packages = let
    #flathub = appId: { inherit appId; origin = "flathub"; };
    aagl = appId: { inherit appId; origin = "launcher.moe"; };
  in
  [
    (aagl "moe.launcher.the-honkers-railway-launcher")
  ];

  services.flatpak = {
    uninstallUnmanaged = true;

    # FIX: these do not work
    overrides.global = {
      # Give access to GTK themes & icons
      Context.filesystems = [
        "xdg-config/gtk-3.0:ro"
        "xdg-config/gtk-4.0:ro"
        "xdg-data/icons:ro"
      ];

      # Fix unthemed cursor in some Wayland apps
      Environment.XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
    };
  };
}

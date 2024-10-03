{ inputs, ... }:

{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  # Nix-flatpak
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "launcher.moe";
        location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
      }
    ];

    packages = [
      {
        appId = "moe.launcher.the-honkers-railway-launcher";
        origin = "launcher.moe";
      }
    ];

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

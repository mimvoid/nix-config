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
    flathub = appId: { inherit appId; origin = "flathub"; };
    aagl = appId: { inherit appId; origin = "launcher.moe"; };
  in
  [
    (flathub "io.github.giantpinkrobots.flatsweep")
    (aagl "moe.launcher.the-honkers-railway-launcher")
  ];

  services.flatpak = {
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    overrides.global = {
      # Fix unthemed cursor in some Wayland apps
      Environment.XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
    };
  };
}

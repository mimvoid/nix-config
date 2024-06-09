{ pkgs, ... }:
# Desktop entries
{
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/obsidian.svg";

      # TODO: what is the variable for an appimageTool package?
      exec = "/nix/store/4vx2sszc7x7pz0fpywdgfncva7dawsky-Obsidian-1.6.3/bin/Obsidian %u";
      terminal = false;
    };
    krita = {
      name = "Krita";
      icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/krita.svg";
      exec = "/nix/store/qg5w1h3rq6wg4g9q6d32n82jv48vryss-krita-5.2.2/bin/krita %u";
      terminal = false;
    };
  };
}

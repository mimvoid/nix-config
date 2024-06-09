{ pkgs, ... }:
# Desktop entries
{
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian.AppImage";
      icon = "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/obsidian.svg";

      # TODO: what is the variable for an appimageTool package?
      exec = "${../packages/result/bin/Obsidian} %u";
      terminal = false;
    };
  };
}

# Desktop entries
{
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian.AppImage";

      # TODO: what is the variable for an appimageTool package?
      exec = "${../../packages/result/bin/Obsidian} %u";
      terminal = false;
    };
  };
}

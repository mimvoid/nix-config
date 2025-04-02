import { bind } from "astal";
import { Astal, App, Gtk, Gdk } from "astal/gtk4";

import { pointer } from "@lib/utils";
import { ScrolledWindow } from "@lib/astalified";
import Wallpapers from "@services/wallpapers";

const wallpapers = Wallpapers.get_default();

const Choices = bind(wallpapers, "wallpapers").as((ws) =>
  ws.map((w) => (
    <button
      setup={pointer}
      cssClasses={["item"]}
      onClicked={() => {
        if (w[0]) wallpapers.setWallpaper(wallpapers.wallpaperDir + w[0]);
      }}
    >
      <box vertical spacing={4}>
        <image file={w[1] || wallpapers.wallpaperDir + w[0] || ""} />
        <label cssClasses={["filename"]} label={w[0] || ""} />
      </box>
    </button>
  )),
);

export default async function WallpaperPicker() {
  const { EXTERNAL, NEVER } = Gtk.PolicyType;
  const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      cssClasses={["wallpaper-picker", "popover"]}
      name="wallpaperPicker"
      anchor={BOTTOM | LEFT | RIGHT}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.NORMAL}
      keymode={Astal.Keymode.EXCLUSIVE}
      onKeyPressed={(_, keyval) => {
        if (keyval === Gdk.KEY_Escape) {
          App.toggle_window("wallpaperPicker");
        }
      }}
      application={App}
      marginBottom={12}
    >
      <ScrolledWindow
        hscrollbarPolicy={EXTERNAL}
        vscrollbarPolicy={NEVER}
        widthRequest={1200}
      >
        <box spacing={8}>{Choices}</box>
      </ScrolledWindow>
    </window>
  );
}

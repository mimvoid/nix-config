import { bind } from "astal";
import { Astal, App, Gtk, Gdk } from "astal/gtk4";
import Gio from "gi://Gio";

import { pointer } from "@lib/utils";
import { ScrolledWindow, Picture } from "@lib/astalified";
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
      <box vertical spacing={8}>
        <overlay>
          <box heightRequest={120} widthRequest={240} />
          <Picture
            type="overlay clip measure"
            file={Gio.File.new_for_path(
              w[1] || wallpapers.wallpaperDir + w[0] || "",
            )}
            valign={Gtk.Align.FILL}
          />
        </overlay>
        <label cssClasses={["filename"]} label={w[0] || ""} />
      </box>
    </button>
  )),
);

export default () => {
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
      onKeyPressed={(self, keyval) => {
        if (keyval === Gdk.KEY_Escape) self.visible = false;
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
  ) as Gtk.Window;
};

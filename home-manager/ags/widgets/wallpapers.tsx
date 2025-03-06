import { bind } from "astal";
import { Astal, App, Gtk, Gdk } from "astal/gtk4";
import Gio from "gi://Gio";

import { pointer } from "@lib/utils";
import { Picture, ScrolledWindow } from "@lib/astalified";
import Wallpapers from "@services/wallpapers";

const wallpapers = Wallpapers.get_default();

const Choices = bind(wallpapers, "wallpapers").as((ws) =>
  ws.map((w) => (
    <button
      setup={pointer}
      cssClasses={["item"]}
      onClicked={() => wallpapers.setWallpaper(w.path)}
    >
      <box vertical spacing={4}>
        <Picture
          file={Gio.File.new_for_path(w.thumbnail || w.path)}
          contentFit={Gtk.ContentFit.COVER}
        />
        <label cssClasses={["filename"]} label={w.name} />
      </box>
    </button>
  ))
);

export default function WallpaperPicker() {
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
      <ScrolledWindow hscrollbarPolicy={EXTERNAL} vscrollbarPolicy={NEVER} widthRequest={1200}>
        <box spacing={8}>
          {Choices}
        </box>
      </ScrolledWindow>
    </window>
  )
}

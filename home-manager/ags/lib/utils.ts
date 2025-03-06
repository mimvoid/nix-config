import { Gtk, Gdk } from "astal/gtk4";

const pointerCursor = Gdk.Cursor.new_from_name("pointer", null);

export function pointer(self: Gtk.Widget) {
  self.set_cursor(pointerCursor);
}

import { Gtk, Gdk } from "astal/gtk4";

const pointerCursor = Gdk.Cursor.new_from_name("pointer", null);

export function pointer(self: Gtk.Widget) {
  self.set_cursor(pointerCursor);
}

export function drawValuePercentage(w: Gtk.Scale) {
  w.drawValue = true;
  w.valuePos = Gtk.PositionType.RIGHT;
  w.set_format_value_func((_, value) => `${Math.floor(value * 100)}%`);
}

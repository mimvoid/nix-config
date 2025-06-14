import { Gtk } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland";

export function pointer(self: Gtk.Widget) {
  self.set_cursor_from_name("pointer");
}

export function drawValuePercentage(w: Gtk.Scale) {
  w.drawValue = true;
  w.valuePos = Gtk.PositionType.RIGHT;
  w.set_format_value_func((_, value) => `${Math.floor(value * 100)}%`);
}

export function sendHyprlandBatch(batch: string[]) {
  // Taken from epik-shell
  const cmd = batch
    .filter((x) => !!x)
    .map((x) => `keyword ${x}`)
    .join("; ");

  AstalHyprland.get_default().message(`[[BATCH]]/${cmd}`);
}

export function setLayerrules(namespace: string, rules: string[]) {
  sendHyprlandBatch(rules.map((rule) => `layerrule ${rule}, ${namespace}`));
}

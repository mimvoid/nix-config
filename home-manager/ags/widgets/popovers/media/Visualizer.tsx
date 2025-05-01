import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Cava from "gi://AstalCava";

const { END, FILL } = Gtk.Align;

export default () => {
  const cava = Cava.get_default()!;
  cava.bars = 12;

  return (
    <box
      setup={(self) => bind(self, "visible").as((v) => (cava.active = v))}
      cssClasses={["cava"]}
      spacing={2}
      valign={END}
      halign={FILL}
    >
      {bind(cava, "values").as((values) =>
        values.map((v) => (
          <slider
            value={v}
            inverted
            orientation={Gtk.Orientation.VERTICAL}
            halign={FILL}
            hexpand
          />
        )),
      )}
    </box>
  );
}
